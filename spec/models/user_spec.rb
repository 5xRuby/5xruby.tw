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

    context "user doesn't exist in db" do
      let(:omniauth) { FactoryGirl.create(:omniauth) }

      it "create a new user" do
        expect { User.from_omniauth(omniauth) }.to change { described_class.count }.by(1)
        user = User.last
        expect(user.email).to eq("test@test.com")
        expect(user.name).to eq("super mario")
      end
    end
  end
end
