require 'rails_helper'

RSpec.describe "Admin::Videos", :type => :request do
  describe "GET /admin_videos" do
    it "works! (now write some real specs)" do
      get admin_videos_path
      expect(response).to have_http_status(200)
    end
  end
end
