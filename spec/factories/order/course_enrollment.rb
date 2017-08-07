# frozen_string_literal: true

FactoryGirl.define do
  factory :course_enrollment, class: Order::CourseEnrollment do
    order { create(:order) }
    activity_course { create(:activity_course) }
  end
end
