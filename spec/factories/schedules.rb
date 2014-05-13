# == Schema Information
#
# Table name: schedules
#
#  id          :integer          not null, primary key
#  stage_id    :integer          not null
#  date        :date             not null
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule do
    stage nil
    date { rand(1.month).from_now }
    description { "<p>#{Faker::Lorem.paragraph}</p>" }

    ignore do
      events_count 4
    end

    after(:build) do |schedule, evaluator|
      schedule.events = build_list(:event, evaluator.events_count)
    end
  end
end
