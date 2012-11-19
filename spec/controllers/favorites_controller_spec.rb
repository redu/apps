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

    it "should assign user favorites" do
      get :index, user_id: @user, locale: 'pt-BR'
      assigns(:apps).should_not be_nil
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

    it "should not allow duplicate favorites" do
      @user.apps << @app1
      expect {
         post :create, app_id: @app1, user_id: @user, locale: 'pt-BR'
      }.to raise_exception(ActiveRecord::RecordInvalid,
                           'A validação falhou: User já está em uso')
    end
  end

  context "when destroying user favorite" do
    before(:each) do
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
