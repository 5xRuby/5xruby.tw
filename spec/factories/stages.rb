# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stage do
    course nil
    title "MyString"
    description "MyText"
  end
end
