FactoryBot.define do
  factory :user do
    name { "User1" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password1" }
    password_confirmation { "password1" }
    admin { false }
  end

  factory :user2, class: User do
    name { 'User2' }
    email { 'second@gmail.com' }
    password { "password2" }
    password_confirmation { "password2" }
    admin { true }
  end
end
