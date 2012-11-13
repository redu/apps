require 'spec_helper'
require 'authlogic/test_case'

describe UserSessionsController do
  describe "GET 'create'" do
    before do
      @user = FactoryGirl.create(:user)
    end

    context 'with correct credentials' do
      before do
        @login_params = { :user_session => {
          :login => @user.login,
          :password => @user.password }
        }
      end

      it 'logs the user in' do
        post :create, @login_params.merge!(:locale => 'pt-BR')
        controller.send(:current_user).should == @user
      end

      context 'the request is through AJAX' do
        render_views

        it 'changes the header to the nav_local' do
          xhr :post, :create, @login_params.merge!(:locale => 'pt-BR')
          response.body.should include("replaceWith")
          response.body.should include("$newHeader")
        end
      end

      context 'using email as login' do
        before do
          @login_params[:user_session][:login] = @user.email
        end

        it 'logs the user in' do
          post :create, @login_params.merge!(:locale => 'pt-BR')
          controller.send(:current_user).should == @user
        end
      end
    end

    context 'with wrong credentials' do
      before do
        @login_params = { :user_session => {
          :login => @user.login,
          :password => 'wrongpass' }
        }
      end

      it 'do NOT logs the user in' do
        post :create, @login_params.merge!(:locale => 'pt-BR')
        controller.send(:current_user).should be_nil
      end

      context 'the request is through AJAX' do
        render_views

        it 'shows form errors' do
          xhr :post, :create, @login_params.merge!(:locale => 'pt-BR')
          response.body.should include("replaceWith")
          response.body.should include("$newForm")
        end
      end
    end
  end

  describe "POST 'destroy'" do
    include Authlogic::TestCase

    before do
      @user = FactoryGirl.create(:user)
      activate_authlogic
      UserSession.create @user
    end

    it "logs the user out" do
      post :destroy, :locale => 'pt-BR'
      controller.send(:current_user).should be_nil
    end

    context 'the request is through AJAX' do
      render_views

      it 'changes the nav_local to the header' do
        xhr :post, :destroy, :locale => 'pt-BR'
        response.body.should include("replaceWith")
        response.body.should include("$newHeader")
      end
    end
  end

end
