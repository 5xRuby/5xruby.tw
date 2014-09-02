# == Schema Information
#
# Table name: stages
#
#  id          :integer          not null, primary key
#  course_id   :integer          not null
#  title       :string(255)      not null
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  duration    :float            default(0.0), not null
#  date        :date             default(Tue, 02 Sep 2014), not null
#  start_at    :time             default(2000-01-01 20:52:59 UTC), not null
#  end_at      :time             default(2000-01-01 21:52:59 UTC), not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stage do
    sequence :sort_id, 0
    course nil
    title { Faker::Name.title }
    description { Faker::Lorem.paragraph }
    duration { rand(20) / 10.0 }

    ignore do
      schedules_count 3
    end

    after(:build) do |stage, evaluator|
      stage.schedules = build_list(:schedule, evaluator.schedules_count)
    end
  end
end
