require 'rails_helper'

RSpec.describe Course, type: :model do
  it { is_expected.to have_many(:stages) }
  it { is_expected.to have_many(:translations) }
  it { is_expected.to have_and_belong_to_many(:camps) }
  it { is_expected.to have_and_belong_to_many(:talks) }
  it { is_expected.to have_and_belong_to_many(:speakers) }

  describe "callbacks" do
    let(:category) { create(:category) }
    it '#reset_category_counter' do
      expect(category.courses_count).to eq 0
      3.times { course = create(:course) }
      expect(category.reload.courses_count).to eq 3
    end
  end
end
