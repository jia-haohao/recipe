class Cook < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader

  with_options presence: true do
    validates :title
    validates :describe
    validates :image
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "describe", "id", "image", "title", "updated_at", "user_id"]
  end
end
