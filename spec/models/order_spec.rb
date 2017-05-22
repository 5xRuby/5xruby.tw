require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:activitiable) }
  it { is_expected.to validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
end
