# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    image { Faker::Image.image }
    title { Faker::Name.title }
    subtitle { Faker::Lorem.sentence }
    summary { "<p>#{Faker::Lorem.paragraph}</p>" }
    description { "<p>#{Faker::Lorem.paragraph}</p>" }
    what_will_learn { "<p>#{Faker::Lorem.paragraph}</p>" }

    ignore do
      stages_count 6
    end

    after(:build) do |course, evaluator|
      stages = build_list(:stage, evaluator.stages_count, course: course)
      stages.each_with_index{|s, i| s.sort_id = i}
      course.stages = stages
    end
  end
end
