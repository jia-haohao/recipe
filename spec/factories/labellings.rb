FactoryBot.define do
  factory :labelling do
    association :cook
    association :label
  end
end