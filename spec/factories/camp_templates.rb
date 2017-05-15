FactoryGirl.define do
  factory :camp_template do
    title { Faker::Name.name }
    payload { {int: Random.rand(1000), lorem: Faker::Lorem.paragraph} }
  end
end
