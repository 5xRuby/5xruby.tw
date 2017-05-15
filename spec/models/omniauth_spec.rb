require 'rails_helper'

RSpec.describe Omniauth, type: :model do
  context "#from_auth_hash" do
    before(:each) do
      @auth_hash = {
        'provider': 'facebook',
        'uid': '1234567',
        'info': { 'email': 'test@email', 'name': 'username' }
      }
    end

    it "omniauth is not exist" do
      omniauth = Omniauth.from_auth_hash(@auth_hash)

      expect(omniauth).not_to be_nil
      expect(omniauth.email).to eq 'test@email'
      expect(omniauth.name).to eq 'username'
    end

    it "omniauth is exist" do
      Omniauth.create(provider: @auth_hash['provider'], uid: @auth_hash['uid'], payload: @auth_hash)
      omniauth = Omniauth.from_auth_hash(@auth_hash)

      expect(omniauth).not_to be_nil
      expect(omniauth.email).to eq 'test@email'
      expect(omniauth.name).to eq 'username'
    end
  end


end
