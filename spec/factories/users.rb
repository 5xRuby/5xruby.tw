FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password Faker::Internet.password
    name { Faker::Name.name }
    phone { "0911111111" }
  end
end
