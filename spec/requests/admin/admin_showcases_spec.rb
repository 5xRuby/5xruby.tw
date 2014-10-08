require 'rails_helper'

RSpec.describe "Admin::Showcases", :type => :request do
  describe "GET /admin_showcases" do
    it "works! (now write some real specs)" do
      get admin_showcases_path
      expect(response).to have_http_status(200)
    end
  end
end
