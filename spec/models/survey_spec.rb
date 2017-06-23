require 'rails_helper'

RSpec.describe Survey, type: :model do
  it { is_expected.to have_many(:activities) }
end
