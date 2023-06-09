class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6, maximum: 255 },on: [:new, :create]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :profile_image, ProfileImageUploader
  
  has_many :cooks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_cooks, through: :favorites, source: :cook
  has_many :messages, dependent: :destroy

  has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def already_favorited?(cook)
    self.favorites.exists?(cook_id: cook.id)
  end

  def follow!(other_user)
    return if following?(other_user)
    active_relationships.create(followed_id: other_user.id)
  end
  
  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      #user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      user.name = "ゲスト" 
    end
  end

  def self.guest_admin
    find_or_create_by!(email: 'guest_admin@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "管理者ゲスト"
    end
  end

  before_destroy :destroy_action
  before_update :update_action

  private 

  def destroy_action
    if User.where(admin: true).count == 1 && self.admin
      throw(:abort)
    elsif email == 'guest@example.com' || email == 'guest_admin@example.com'
      errors.add(:base, "ゲストユーザーを削除できません．")
      throw(:abort)
    end
  end

  def update_action
    user = User.find_by(admin: true)
    if User.where(admin: true).count == 1 && self.admin_change == [true,false]
      errors.add(:admin, '管理ユーザーから外せません。最低一人の管理者が必要です')
      throw(:abort)
    end
  end
end
