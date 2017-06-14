FactoryGirl.define do
  factory :survey do
    title { Faker::Name.title }
    questions { {} }
  end
end
