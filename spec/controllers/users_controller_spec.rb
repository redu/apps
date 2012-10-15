require 'spec_helper'

describe UsersController do
  context "when listing user favorites" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @app1 = FactoryGirl.create(:app)
      @app2 = FactoryGirl.create(:app)
      @user.apps << [@app1, @app2]
      #ruido
      FactoryGirl.create(:app)
      FactoryGirl.create(:app)
    end

    it "should return user favorites" do
      get :favorites, :user_id => @user.id
      @user.apps.to_set.should == assigns(:apps).to_set
    end
  end
end
