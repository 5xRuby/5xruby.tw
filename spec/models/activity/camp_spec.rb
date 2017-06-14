require 'rails_helper'

RSpec.describe Activity::Camp, type: :model do
  it { is_expected.to have_and_belong_to_many(:courses) }
  it { is_expected.to belong_to(:template).class_name("CampTemplate") }
end
