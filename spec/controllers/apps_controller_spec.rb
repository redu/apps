require 'spec_helper'

describe AppsController do
  describe "GET index" do
    context "When filtering app by category" do
      before(:each) do
        @categories = (0..3).collect {|i| Category.create(:name => "Cat #{i}")}
        @apps = 10.times.collect do |i|
          # app = App.create(:name => "App #{i}")
          app = FactoryGirl.create(:app)
          app.categories << @categories.sample(rand(4))
          app
        end
      end

      xit "should return correct number of apps" do
        get :index , :filter => [@categories.first.name], :locale => 'pt-BR'
        correct_number = @apps.select {|a| a.categories.include?(@categories.first) }.length
        assigns(:apps).length.should == correct_number
      end

      xit "should return corret type of apps" do
        get :index, :filter => [@categories.first.name], :locale => 'pt-BR'
        assigns(:apps).all? {|a| a.categories.include?(@categories.first)}.should == true
      end
    end
  end

  describe "GET show" do
    before do
       @app = FactoryGirl.create(:app)
    end

    context "with valid params" do
      before do
        @params = { :id => @app.id, :locale => 'pt-BR' }
      end

      it "increments app views counter" do
        before = @app.views
        get :show, @params
        App.find(@app.id).views.should == before + 1
      end

      it "assigns the proper app" do
        get :show, @params
        assigns(:app).should == App.find(@params[:id])
      end

      context "when user is logged in" do
        before do
          @user = FactoryGirl.create(:user)
          session[:user_uid] = @user.uid
        end

        it "assigns the current user" do
          get :show, @params
          assigns(:user).should == @user
        end

        it "assigns a bool which indicates wheter the user has rated" do
          get :show, @params
          assigns(:evaluated).should_not be_nil
        end

        context "and has rated the app" do
          before do
            @user_rating = 5
            @app.add_evaluation(:rating, @user_rating, @user)
            get :show, @params
          end

          it "assigns evaluated true" do
            assigns(:evaluated).should be_true
          end

          it "assigns evaluation value" do
            assigns(:user_rating).should == @user_rating
          end
        end

        context "and has'nt rated the app" do
          it "assigns evaluated false" do
            assigns(:evaluated).should be_false
          end

          it "does not assign evaluation value" do
            assigns(:user_rating).should be_nil
          end
        end # context "and has'nt rated the app"
      end # context "when user is logged in"
    end # context "with valid params"
  end # describe "GET show"

  describe "POST rate" do
    before do
      @app = FactoryGirl.create(:app)
      @user = FactoryGirl.create(:user)
      session[:user_uid] = @user.uid # Seta usuário da sessão
    end

    context "with valid params" do
      before do
        request.env["HTTP_REFERER"] = app_path(@app)
        @params = { :id => @app, :rating => 5, :locale => 'pt-BR' }
      end

      it "redirects to HTTP referer" do
        post :rate, @params
        should respond_with(:redirect)
      end

      context "when user hasn't rated before" do
        it "should create a new reputation value" do
          expect {
            post :rate, @params
          }.to change(ReputationSystem::Reputation, :count).by(1)
        end
      end

      context "when user has rated before" do
        before do
          @app.add_evaluation(:rating, @params[:rating]-1, @user)
        end

        it "should not create a new reputation value" do
          expect {
            post :rate, @params
          }.to change(ReputationSystem::Reputation, :count).by(0)
        end

        it "should update reputation value" do
          post :rate, @params
          @app.reputation_for(:rating, nil, @user).should == @params[:rating]
        end
      end # context "when user has rated before"
    end # context "with valid params"
  end # describe "POST rate"
end
