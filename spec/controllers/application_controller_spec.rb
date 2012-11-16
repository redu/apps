require 'spec_helper'
require 'authlogic/test_case'

describe ApplicationController do
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
        UserSession.create(@user)
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
end
