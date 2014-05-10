# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule do
    stage nil
    date "2014-05-11"
    description "MyText"
  end
end
