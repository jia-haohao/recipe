FactoryBot.define do
  factory :favorite do
    association :cook
    association :user
  end
end
