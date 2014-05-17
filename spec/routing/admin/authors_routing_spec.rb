require "spec_helper"

describe Admin::AuthorsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/authors").should route_to("admin/authors#index")
    end

    it "routes to #new" do
      get("/admin/authors/new").should route_to("admin/authors#new")
    end

    it "routes to #show" do
      get("/admin/authors/1").should route_to("admin/authors#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/authors/1/edit").should route_to("admin/authors#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/authors").should route_to("admin/authors#create")
    end

    it "routes to #update" do
      put("/admin/authors/1").should route_to("admin/authors#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/authors/1").should route_to("admin/authors#destroy", :id => "1")
    end

  end
end
