FactoryBot.define do
  factory :cook do
    title { 'test1' }
    describe { 'text1' }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no-image.png')) }
    association :user
  end
  # trait :with_image do
  #   image { File.new("#{Rails.root}/spec/fixtures/image.jpg") }
  #  end

  factory :cook2, class: Cook do
    title { 'test2' }
    describe { 'text2' }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/meal.png')) }
    association :user
  end
end
