class Label < ApplicationRecord
  has_many :labellings, dependent: :destroy 
  has_many :cooks, through: :labellings 

  def self.ransackable_attributes(auth_object = nil)
    %w(id name created_at updated_at)
  end

  def self.ransackable_associations(auth_object = nil)
    %w(labellings cooks)
  end
end
