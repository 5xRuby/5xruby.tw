# frozen_string_literal: true

FactoryGirl.define do
  factory :camp, class: Activity::Camp do
    type { "Activity::Camp" }
    title { Faker::Name.name }
    permalink { SecureRandom.hex(4) }
    payment_note { Faker::Lorem.sentence }
    note { Faker::Lorem.sentence }
    is_online { true }
    template { create(:camp_template) }
    rules { Hash.new }

    after(:build) do |camp, evaluator|
      (1..4).to_a.sample.times do
        camp.activity_courses << build(:activity_course, activity_id: camp.id, course_id: create(:course).id)
      end
    end
  end
end
