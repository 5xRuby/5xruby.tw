require "spec_helper"

describe Admin::SchedulesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/schedules").should route_to("admin/schedules#index")
    end

    it "routes to #new" do
      get("/admin/schedules/new").should route_to("admin/schedules#new")
    end

    it "routes to #show" do
      get("/admin/schedules/1").should route_to("admin/schedules#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/schedules/1/edit").should route_to("admin/schedules#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/schedules").should route_to("admin/schedules#create")
    end

    it "routes to #update" do
      put("/admin/schedules/1").should route_to("admin/schedules#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/schedules/1").should route_to("admin/schedules#destroy", :id => "1")
    end

  end
end
