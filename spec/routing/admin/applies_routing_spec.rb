require "spec_helper"

describe Admin::AppliesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/applies").should route_to("admin/applies#index")
    end

    it "routes to #new" do
      get("/admin/applies/new").should route_to("admin/applies#new")
    end

    it "routes to #show" do
      get("/admin/applies/1").should route_to("admin/applies#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/applies/1/edit").should route_to("admin/applies#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/applies").should route_to("admin/applies#create")
    end

    it "routes to #update" do
      put("/admin/applies/1").should route_to("admin/applies#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/applies/1").should route_to("admin/applies#destroy", :id => "1")
    end

  end
end
