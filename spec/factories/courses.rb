# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    image { Faker::Image.image }
    title { Faker::Name.title }
    summary { Faker::Lorem.paragraph }
    description { Faker::Lorem.paragraph }
    what_will_learn { Faker::Lorem.paragraph }

    ignore do
      stages_count 6
    end

    after(:create) do |course, evaluator|
      create_list(:stage, evaluator.stages_count, course: course)
    end
  end
end
