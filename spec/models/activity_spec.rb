require 'rails_helper'

RSpec.describe Activity, type: :model do
  it { is_expected.to have_and_belong_to_many(:courses) }
  it { is_expected.to belong_to(:template) }
  it { is_expected.to have_many(:translations) }
  it { is_expected.to have_many(:activity_courses) }
  it { is_expected.to have_many(:orders) }
  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:permalink) }
  it { is_expected.to validate_presence_of(:note) }
  it { is_expected.to validate_presence_of(:payment_note) }

  describe "validations" do
    let(:template) { create(:camp_template) }
    let(:camp) { build(:camp) }
    let(:talk) { build(:talk) }

    describe "#validate_template" do
      it "not pass" do
        camp.template = nil
        expect(camp).not_to be_valid
      end

      it "not pass" do
        talk.template = template
        expect(talk).not_to be_valid
      end

      it "pass" do
        expect(camp).to be_valid
      end

      it "pass" do
        expect(talk).to be_valid
      end
    end
  end
end
