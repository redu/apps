require 'spec_helper'
require 'cancan/matchers'

describe 'App ability' do
  let(:user) { FactoryGirl.create(:user) }
  let(:app) { FactoryGirl.create(:app) }

  context 'when not logged in' do
    subject { Ability.new(nil) }

    it 'should be able to read an App' do
      subject.should be_able_to(:read, app)
    end

    it 'should not be able to rate an App' do
      subject.should_not be_able_to(:rate, app)
    end

    it 'should not be able to checkout an App' do
      subject.should_not be_able_to(:checkout, app)
    end
  end

  context 'when logged in' do
    subject { Ability.new(user) }

    it 'should be able to read an App' do
      subject.should be_able_to(:read, app)
    end

    it 'should be able to rate an App' do
      subject.should be_able_to(:rate, app)
    end

    it 'should be able to checkout an App' do
      subject.should be_able_to(:checkout, app)
    end
  end
end
