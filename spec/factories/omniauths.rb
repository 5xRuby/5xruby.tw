FactoryGirl.define do
  factory :omniauth do
    provider "facebook"
    uid "1234"
    user
    payload do
      {
        email: Faker::Internet.email,
        name: Faker::Internet.user_name
      }.to_json
    end
  end
end
