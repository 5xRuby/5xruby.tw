require "spec_helper"

describe Admin::FaqsController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/faqs").should route_to("admin/faqs#index")
    end

    it "routes to #new" do
      get("/admin/faqs/new").should route_to("admin/faqs#new")
    end

    it "routes to #show" do
      get("/admin/faqs/1").should route_to("admin/faqs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/faqs/1/edit").should route_to("admin/faqs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/faqs").should route_to("admin/faqs#create")
    end

    it "routes to #update" do
      put("/admin/faqs/1").should route_to("admin/faqs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/faqs/1").should route_to("admin/faqs#destroy", :id => "1")
    end

  end
end
