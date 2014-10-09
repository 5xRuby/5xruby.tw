require "rails_helper"

RSpec.describe Admin::VideosController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/videos").to route_to("admin/videos#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/videos/new").to route_to("admin/videos#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/videos/1").to route_to("admin/videos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/videos/1/edit").to route_to("admin/videos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/videos").to route_to("admin/videos#create")
    end

    it "routes to #update" do
      expect(:put => "/admin/videos/1").to route_to("admin/videos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/videos/1").to route_to("admin/videos#destroy", :id => "1")
    end

  end
end
