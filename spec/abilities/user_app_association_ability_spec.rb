require 'spec_helper'
require 'cancan/matchers'

describe 'UserAppAssociation ability' do
  let(:user) { FactoryGirl.create(:user) }
  let(:user_app_assoc) { FactoryGirl.create(:user_app_association) }

  context 'when not logged in' do
    subject { Ability.new(nil) }

    it 'should not be able to create an UserAppAssociation' do
      subject.should_not be_able_to(:create, UserAppAssociation.new)
    end
  end

  context 'when logged in' do
    subject { Ability.new(user) }

    it 'should be able to create an UserAppAssociation' do
      subject.should be_able_to(:create, UserAppAssociation.new)
    end

    it 'should be able to manage an UserAppAssociation if associated with it' do
      user_app_assoc.user = user
      subject.should be_able_to(:manage, user_app_assoc)
    end

    it 'should not be able to manage an UserAppAssociation if he is not' \
      'associated with it' do
        subject.should_not be_able_to(:manage, user_app_assoc)
    end

    context 'when favorited an app' do
      let(:favorited_app) { FactoryGirl.create(:user_app_association,
                                               user: user) }

      it 'should not be able to create an UserAppAssociation' do
        subject.should_not \
          be_able_to(:create, UserAppAssociation.new(app: favorited_app.app))
      end
    end
  end
end
