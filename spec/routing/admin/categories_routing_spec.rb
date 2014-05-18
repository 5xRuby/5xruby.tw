require "spec_helper"

describe Admin::CategoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/categories").should route_to("admin/categories#index")
    end

    it "routes to #new" do
      get("/admin/categories/new").should route_to("admin/categories#new")
    end

    it "routes to #show" do
      get("/admin/categories/1").should route_to("admin/categories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/categories/1/edit").should route_to("admin/categories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/categories").should route_to("admin/categories#create")
    end

    it "routes to #update" do
      put("/admin/categories/1").should route_to("admin/categories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/categories/1").should route_to("admin/categories#destroy", :id => "1")
    end

  end
end
