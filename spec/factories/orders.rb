# frozen_string_literal: true

FactoryGirl.define do
  factory :order do
    activity { create(%i[talk camp].sample) }
    amount { Faker::Number.between(10000, 20000) }
    ans { Hash.new }
    user { create(:user) }

    after(:build) do |order, evaluator|
      order.course_enrollments << build(:course_enrollment, order: order, activity_course: order.activity.activity_courses.sample)
    end
  end
end
