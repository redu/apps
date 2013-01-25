# encoding: utf-8
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
      controller.stub(current_user: @user)
    end

    it "assigns correct user favorites" do
      get :index, user_id: @user, locale: 'pt-BR'
      assigns(:apps).should == [@app1, @app2]
    end

    context "and filtering them" do
      before do
        @best_apps = FactoryGirl.create(:category, name: "best apps")
        @bad_apps = FactoryGirl.create(:category, name: "bad apps")
        @my_app = FactoryGirl.create(:app)
        @my_app.categories << @best_apps
        @your_app = FactoryGirl.create(:app)
        @your_app.categories << @bad_apps
        @user.apps << [@my_app, @your_app]
      end

      it "acknowledges the best apps" do
        get :index, user_id: @user, locale: 'pt-BR', filter: [@best_apps.id]
        assigns(:apps).should == [@my_app]
      end

      it "acknowledges the bad apps" do
        get :index, user_id: @user, locale: 'pt-BR', filter: [@bad_apps.id]
        assigns(:apps).should == [@your_app]
      end

      it "acknowledges not criterious users" do
        get :index, user_id: @user, locale: 'pt-BR',
          filter: [@best_apps, @bad_apps.id]
        assigns(:apps).should == [@my_app, @your_app]
      end
    end

    context "for an user who loves apps so much" do
      before do
        cat = FactoryGirl.create(:category)
        @per_page = ReduApps::Application.config.apps_per_page
        (@per_page + 1).times do |n|
          @app = FactoryGirl.create(:app)
          @app.categories << cat
          @user.apps << @app
        end
        get :index, user_id: @user, locale: 'pt-BR', filter: [cat.id]
      end

      it "paginates them" do
        assigns(:apps).length.should == @per_page
      end

      it "counts them before pagination execution" do
        assigns(:favorite_apps_count).should == @user.apps.length
      end

      it "assigns filters before pagination execution" do
        assigns(:favorite_apps_filters).should == Category.filters_on(@user.apps)
      end

      it "counts assigned filters before pagination execution" do
        assigns(:favorite_apps_filters_counter).should ==
          Category.count_filters_on(Category.filters_on(@user.apps))
      end
    end

    context "for an admin user" do
      before do
        controller.stub(current_user: FactoryGirl.create(:user, core_role: 1))
      end

      it "should assign correct user favorites" do
        get :index, user_id: @user, locale: 'pt-BR'
        assigns(:apps).should == [@app1, @app2]
      end
    end
  end

  context "when creating user favorite" do
    before(:each) do
      controller.stub(current_user: @user)
    end

    it "should add app to favorites list" do
      post :create, app_id: @app1, user_id: @user, locale: 'pt-BR'
      @user.apps.should include @app1
    end
  end

  context "when destroying user favorite" do
    before(:each) do
      controller.stub(current_user: @user)
      @user.apps << [@app1, @app2]
    end

    it "should remove user favorite" do
      assoc_id = @user.user_app_associations.where(app_id: @app1.id).first.id
      expect {
        delete :destroy,
               id: UserAppAssociation.find_by_user_id_and_app_id(@user, @app1),
               user_id: @user, locale: 'pt-BR'
      }.to change(@user.apps, :count).by(-1)
    end
  end
end
