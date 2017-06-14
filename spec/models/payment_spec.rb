require 'rails_helper'

RSpec.describe Payment, type: :model do
  it { is_expected.to belong_to(:order) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:type) }
end
