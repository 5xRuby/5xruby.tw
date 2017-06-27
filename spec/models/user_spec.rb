require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:omniauths) }

  let(:user) { FactoryGirl.create(:user) }

  describe "#from_omniauth" do
    context "user exist in db" do
      let!(:omniauth) { FactoryGirl.create(:omniauth) }

      it "won't create a new user" do
        expect { User.from_omniauth(omniauth) }.to change { described_class.count }.by(0)
      end
    end
  end
end
