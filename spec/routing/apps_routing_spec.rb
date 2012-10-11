require "spec_helper"

describe AppsController do
  describe "routing" do

    it "routes to #index" do
      get("/apps").should route_to("apps#index")
    end

    it "routes to #show" do
      get("/apps/1").should route_to("apps#show", :id => "1")
    end

  end
end
