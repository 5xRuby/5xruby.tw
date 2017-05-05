require 'rails_helper'

RSpec.describe Activity, type: :model do
  it { is_expected.to have_and_belong_to_many(:courses) }
end
