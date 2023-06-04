class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :cook, class_name: 'Cook'
  validates_uniqueness_of :cook_id, scope: :user_id
end
