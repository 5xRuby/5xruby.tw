# == Schema Information
#
# Table name: courses
#
#  id              :integer          not null, primary key
#  image           :string(255)
#  title           :string(255)      not null
#  summary         :text
#  description     :text
#  what_will_learn :text
#  created_at      :datetime
#  updated_at      :datetime
#  subtitle        :string(255)
#  category_id     :integer
#  is_online       :boolean          default(FALSE), not null
#  permalink       :string(255)      default("e9bd20e6"), not null
#  note            :text
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    category { Category.order('RANDOM()').first }
    image { Faker::Image.image }
    title { Faker::Name.title }
    permalink { SecureRandom.hex(4) }
    is_online { [true, false].sample }
    subtitle { Faker::Lorem.sentence }
    summary { Faker::Lorem.paragraph.slice(0, 150) }
    description { "<p>#{Faker::Lorem.paragraph}</p>" }
    note { "<p>#{Faker::Lorem.paragraph}</p>" }
    what_will_learn { "<p>#{Faker::Lorem.paragraph}</p>" }

    ignore do
      stages_count 6
      applies_count 3
    end

    after(:build) do |course, evaluator|
      stages = build_list(:stage, evaluator.stages_count)
      stages.each_with_index{|s, i| s.sort_id = i}
      course.stages = stages
    end

    after(:create) do |course, evaluator|
      Schedule.includes(:stage).where(stages: {course_id: course}).each do |schedule|
        create_list(:apply, evaluator.applies_count, course: course, stage: schedule.stage, schedule: schedule)
      end
    end
  end
end
