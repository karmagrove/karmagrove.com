require "spec_helper"

describe EventCharitiesController do
  describe "routing" do

    it "routes to #index" do
      get("/event_charities").should route_to("event_charities#index")
    end

    it "routes to #new" do
      get("/event_charities/new").should route_to("event_charities#new")
    end

    it "routes to #show" do
      get("/event_charities/1").should route_to("event_charities#show", :id => "1")
    end

    it "routes to #edit" do
      get("/event_charities/1/edit").should route_to("event_charities#edit", :id => "1")
    end

    it "routes to #create" do
      post("/event_charities").should route_to("event_charities#create")
    end

    it "routes to #update" do
      put("/event_charities/1").should route_to("event_charities#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/event_charities/1").should route_to("event_charities#destroy", :id => "1")
    end

  end
end
