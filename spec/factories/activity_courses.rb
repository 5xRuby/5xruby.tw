# frozen_string_literal: true

FactoryGirl.define do
  factory :activity_course do
    activity { create(:talk) }
    course { create(:course) }
    price { 10000 }
    early_bird_price { 10000 }
    priority { 1 }
  end
end
