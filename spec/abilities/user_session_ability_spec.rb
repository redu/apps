require 'spec_helper'
require 'cancan/matchers'
require 'authlogic/test_case'

describe 'UserSession ability' do
  include Authlogic::TestCase

  before do
    activate_authlogic
  end

  let(:user) { FactoryGirl.create(:user) }
  let(:user_session) { UserSession.create user }

  context 'when not logged in' do
    subject { Ability.new(nil) }

    it 'should not be able to destroy an UserSession' do
      subject.should_not be_able_to(:destroy, user_session)
    end

    it 'should not be able to destroy a nil UserSession' do
      subject.should_not be_able_to(:destroy, nil)
    end
  end

  context 'when logged in' do
    subject { Ability.new(user) }
    let(:others_user_session) { UserSession.create FactoryGirl.create(:user) }

    it 'should be able to destroy an his UserSession' do
      subject.should be_able_to(:destroy, user_session)
    end

    it 'should not be able to destroy an others UserSession' do
      subject.should_not be_able_to(:destroy, others_user_session)
    end

    context 'when admin' do
      before do
        user.update_attributes(core_role: 1)
      end

      it 'should be able to destroy an others UserSession' do
        subject.should be_able_to(:destroy, others_user_session)
      end
    end
  end
end
