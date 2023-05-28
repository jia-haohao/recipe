class Cook < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader

  with_options presence: true do
    validates :title
    validates :describe
    validates :image
  end
end
