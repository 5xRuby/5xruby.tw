# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :interview_question do
    question  { Faker::Lorem.sentence }
    answer    { Faker::Lorem.paragraph.slice(0, 150) }
    is_online { rand > 0.5 }
  end
end
