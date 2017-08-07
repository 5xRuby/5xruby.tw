FactoryGirl.define do
  factory :survey do
    title { Faker::Name.title }
    questions { Hash.new }
  end
end
