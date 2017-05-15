# frozen_string_literal: true

FactoryGirl.define do
  factory :talk, class: Activity::Talk do
    type { "Activity::Talk" }
    title { Faker::Name.name }
    permalink { Faker::Name.name }
    payment_note { Faker::Lorem.sentence }
    note { Faker::Lorem.sentence }
    is_online { true }

    after(:build) do |talk, evaluator|
      talk.activity_courses << build(:activity_course, activity_id: talk.id, course_id: create(:course).id)
    end
  end
end
