# encoding: utf-8
require 'spec_helper'
require 'authlogic/test_case'

describe ApplicationController do
  describe 'Helpers' do
    context 'path_to_be_back helper' do
      it 'path_to_be_back is a helper method' do
        controller._helper_methods.should include(:path_to_be_back)
      end

      it 'has a private method path_to_be_back' do
        controller.private_methods.should include(:path_to_be_back)
      end

      context 'when the request is made' do
        before do
          request.env['HTTP_REFERER'] = "http://http-referer.com"
          request.env['REQUEST_URI'] = "http://request-uri"
        end

        it 'path_to_be_back returns the http referrer if its through AJAX' do
          request.env['HTTP_X_REQUESTED_WITH'] = 'XMLHttpRequest'
          controller.send(:path_to_be_back).should ==
            request.env['HTTP_REFERER']
        end

        it 'path_to_be_back returns the http uri if its not' \
          'through AJAX' do
            controller.send(:path_to_be_back).should == request.env['REQUEST_URI']
        end
      end
    end
  end

  describe 'AuthlogicHelpers' do
    include Authlogic::TestCase

    before do
      activate_authlogic
    end

    context 'Private Methods' do
      it 'has a private method current_user_session' do
        controller.private_methods.should include(:current_user_session)
      end

      it 'has a private method current_user' do
        controller.private_methods.should include(:current_user)
      end
    end

    context 'when user is logged in' do
      before do
        @user = FactoryGirl.create(:user)
        # Necessário, pois não existe uma requisição
        Authlogic::Session::Base.controller.controller.
          cookies["user_credentials"] = { :value => @user.persistence_token }
      end

      it 'current_user_session returns the session' do
        controller.send(:current_user_session).should be
        controller.send(:current_user_session).should be_a(UserSession)
        controller.send(:current_user_session).user.should == @user
      end

      it 'current_user returns the logged user' do
        controller.send(:current_user).should == @user
      end
    end

    context 'when there is not a user logged' do
      it 'current_user_session returns the nil' do
        controller.send(:current_user_session).should be_nil
      end

      it 'current_user returns nil' do
        controller.send(:current_user).should be_nil
      end
    end

    context 'define helper methods' do
      it 'current_user is a helper method' do
        controller._helper_methods.should include(:current_user)
      end

      it 'current_user_session is a helper method' do
        controller._helper_methods.should include(:current_user_session)
      end
    end
  end

  describe 'AccessDenied' do
    controller do
      def show
        raise CanCan::AccessDenied
      end
    end

    context 'when the user does not have access to some action' do
      context 'with a normal HTTP request' do
        before do
          get :show, id: 'anyid'
        end

        it { should set_the_flash.to(I18n.t :you_do_not_have_access) }
        it { should redirect_to root_path }

        it 'should set session[:return_to] to request path' do
          session[:return_to].should == "/anonymous/anyid"
        end
      end

      context 'with AJAX' do
        before do
          xhr :get, :show, id: 'anyid'
        end

        it { should set_the_flash.to(I18n.t :you_do_not_have_access) }

        it 'should do a redirect with window.location.pathname' do
          response.body.should \
            include("window.location.pathname='#{root_path}'")
        end

        it 'should set session[:return_to] to request path' do
          session[:return_to].should == "/anonymous/anyid"
        end
      end
    end
  end
end
