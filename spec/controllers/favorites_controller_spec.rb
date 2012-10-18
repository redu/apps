require 'spec_helper'

describe FavoritesController do
   before(:each) do
      @user = FactoryGirl.create(:user)
      @app1 = FactoryGirl.create(:app)
      @app2 = FactoryGirl.create(:app)

      #Ruido
      FactoryGirl.create(:app)
      FactoryGirl.create(:app)
   end

   context "when listing user favorites" do
      before(:each) do
         @user.apps << [@app1, @app2]
      end

      it "should return user favorites" do
         get :index, :user_id => @user.id, :locale => 'pt-BR'
         @user.user_app_associations.to_set.should == 
            assigns(:user_apps_association).to_set
      end
   end

   context "when creating user favorite" do
      it "should add app to favorites list" do
         post :create, :app_id => @app1.id, :user_id => @user.id, 
              :locale => 'pt-BR'
         @user.apps.should include @app1
      end

      it "should not allow duplicate favorites" do
         post :create, :app_id => @app1.id, :user_id => @user.id, 
              :locale => 'pt-BR'
         lambda { post :create, :app_id => @app1.id,
            :user_id => @user.id }.should raise_error
      end
   end

   context "when destroying user favorite" do
      before(:each) do
         @user.apps << [@app1, @app2]
      end

      it "should remove user favorite" do
         assoc_id = @user.user_app_associations.where(:app_id => @app1.id).first.id
         expect {
            delete :destroy, :id => @app1.id, :user_id => @user.id,
                   :association_id => assoc_id, :locale => 'pt-BR'
         }.to change(@user.apps, :count).by(-1)
      end
   end
end
