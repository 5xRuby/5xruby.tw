require "rails_helper"

RSpec.describe Admin::ShowcasesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/showcases").to route_to("admin/showcases#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/showcases/new").to route_to("admin/showcases#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/showcases/1").to route_to("admin/showcases#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/showcases/1/edit").to route_to("admin/showcases#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/showcases").to route_to("admin/showcases#create")
    end

    it "routes to #update" do
      expect(:put => "/admin/showcases/1").to route_to("admin/showcases#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/showcases/1").to route_to("admin/showcases#destroy", :id => "1")
    end

  end
end
