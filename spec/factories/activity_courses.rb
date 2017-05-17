# frozen_string_literal: true

FactoryGirl.define do
  factory :activity_course do
    activity { create(:talk) }
    course { create(:course) }
  end
end
