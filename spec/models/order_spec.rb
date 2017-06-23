require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:activity) }
  it { is_expected.to have_many(:course_enrollments).class_name("Order::CourseEnrollment") }
  it { is_expected.to have_many(:activity_courses).through(:course_enrollments) }
  it { is_expected.to have_many(:enrolling_courses).through(:activity_courses).source(:course) }
  it { is_expected.to validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
  it { is_expected.to delegate_method(:survey).to(:activity) }
  it { is_expected.to delegate_method(:questions).to(:survey) }

  describe "custom validation" do
    subject { build(:order) }

    describe "#number_of_course_enrollments" do
      before { subject.course_enrollments = [] }

      it "return error, at least one course enrollment" do
        expect(subject).to be_invalid
        expect(subject.errors[:course_enrollments]).not be_nil
      end
    end
  end
end
