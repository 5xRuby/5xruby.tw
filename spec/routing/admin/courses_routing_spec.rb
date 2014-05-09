require "spec_helper"

describe Admin::CoursesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/courses").should route_to("admin/courses#index")
    end

    it "routes to #new" do
      get("/admin/courses/new").should route_to("admin/courses#new")
    end

    it "routes to #show" do
      get("/admin/courses/1").should route_to("admin/courses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/courses/1/edit").should route_to("admin/courses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/courses").should route_to("admin/courses#create")
    end

    it "routes to #update" do
      put("/admin/courses/1").should route_to("admin/courses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/courses/1").should route_to("admin/courses#destroy", :id => "1")
    end

  end
end
