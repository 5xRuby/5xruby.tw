# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    image "MyString"
    title "MyString"
    summary "MyString"
    description "MyText"
    what_will_learn "MyText"
  end
end
