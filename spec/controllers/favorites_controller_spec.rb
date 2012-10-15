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
         get :index, :user_id => @user.id
         @user.apps.to_set.should == assigns(:apps).to_set
      end
   end

   context "when posting user favorite" do
      it "should add app to favorites list" do
         post :create, :app_id => @app1.id, :user_id => @user.id
         @user.apps.should include @app1
      end
   end
end