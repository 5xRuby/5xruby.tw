# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule do
    stage nil
    date { rand(1.month).from_now }
    description { "<p>#{Faker::Lorem.paragraph}</p>" }
  end
end
