FactoryBot.define do
  factory :comment do
    content { 'text' }
    association :cook
    association :user
  end
end
