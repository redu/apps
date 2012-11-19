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
  end

  context 'when logged in' do
    subject { Ability.new(user) }

    it 'should be able to read an App' do
      subject.should be_able_to(:read, app)
    end
  end
end
