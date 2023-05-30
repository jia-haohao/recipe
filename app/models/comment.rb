class Comment < ApplicationRecord
  belongs_to :cook
  belongs_to :user
  validates :content, presence: true
end
