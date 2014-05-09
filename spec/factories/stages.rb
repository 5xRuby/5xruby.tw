# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stage do
    sequence :sort_id, 0
    course nil
    title { Faker::Name.title }
    description { Faker::Lorem.paragraph }
  end
end
