require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:activity) }
  it { is_expected.to have_many(:course_enrollments).class_name("Order::CourseEnrollment") }
  it { is_expected.to have_many(:activity_courses).through(:course_enrollments) }
  it { is_expected.to have_many(:enrolling_courses).through(:activity_courses).source(:course) }
  it { is_expected.to validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
end
