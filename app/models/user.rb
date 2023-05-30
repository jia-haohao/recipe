class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6, maximum: 255 },on: [:new, :create]
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  mount_uploader :profile_image, ProfileImageUploader
  
  has_many :cooks, dependent: :destroy
  has_many :comments, dependent: :destroy
end
