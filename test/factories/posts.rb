# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    image { Faker::Image.image }
    title { Faker::Name.title }
    content { Faker::Lorem.paragraph }
  end
end
