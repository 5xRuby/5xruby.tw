require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:purchasable) }
  it { is_expected.to have_and_belong_to_many(:activities_courses).class_name("ActivityCourse") }
  it { is_expected.to have_many(:selected_courses).class_name("Course").through(:activities_courses).source(:course) }
  it { is_expected.to validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
end
