FactoryGirl.define do
  factory :user do

    email "test@test.com"
    password Faker::Internet.password
    name "super mario"
    phone "0987654321"
  end
end
