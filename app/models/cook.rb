class Cook < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader

  with_options presence: true do
    validates :title
    validates :describe
    validates :image
  end

  has_many :labellings, dependent: :destroy 
  has_many :labels, through: :labellings

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "describe", "id", "image", "title", "updated_at", "label_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["labellings", "labels"]
  end
end
