# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :apply do
    course nil
    stage nil
    schedule nil
    first_name "MyString"
    last_name "MyString"
    phone "MyString"
    email "MyString"
    age 1
    gender "MyString"
    message "MyText"
  end
end
