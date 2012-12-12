require 'spec_helper'

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
        before do
          request.env["HTTP_REFERER"] = "http://whereiwas.com"
        end
        render_views

        it 'should do a redirect back with window.location' do
          xhr :post, :create, @login_params.merge!(:locale => 'pt-BR')
          response.body.should \
            include("window.location='http://whereiwas.com'")
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
    before do
      @user = FactoryGirl.create(:user)
      cookies["user_credentials"] = { :value => @user.persistence_token }
    end

    it "logs the user out" do
      post :destroy, :locale => 'pt-BR'
      controller.send(:current_user).should be_nil
    end

    context 'the request is through AJAX' do
      before do
        request.env["HTTP_REFERER"] = "http://whereiwas.com"
      end
      render_views

      it 'should do a redirect back with window.location' do
        xhr :post, :destroy, :locale => 'pt-BR'
        response.body.should \
          include("window.location='http://whereiwas.com'")
      end
    end
  end

end
