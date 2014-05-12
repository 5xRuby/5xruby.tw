require "spec_helper"

describe Admin::SpeakersController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/speakers").should route_to("admin/speakers#index")
    end

    it "routes to #new" do
      get("/admin/speakers/new").should route_to("admin/speakers#new")
    end

    it "routes to #show" do
      get("/admin/speakers/1").should route_to("admin/speakers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/speakers/1/edit").should route_to("admin/speakers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/speakers").should route_to("admin/speakers#create")
    end

    it "routes to #update" do
      put("/admin/speakers/1").should route_to("admin/speakers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/speakers/1").should route_to("admin/speakers#destroy", :id => "1")
    end

  end
end
