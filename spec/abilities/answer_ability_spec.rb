require 'spec_helper'
require 'cancan/matchers'

describe 'Answer ability' do
  let(:user) { FactoryGirl.create(:user) }
  let(:comment) { FactoryGirl.create(:comment) }
  let(:answer) { FactoryGirl.create(:answer, in_response_to: comment) }

  context 'when not logged in' do
    subject { Ability.new(nil) }

    it 'should not be able to create an answer' do
      subject.should_not be_able_to(:create, Answer.new)
    end

    it 'should not be able to manage an answer' do
      subject.should_not be_able_to(:manage, answer)
    end

    it 'should be able to read an answer' do
      subject.should be_able_to(:read, answer)
    end
  end

  context 'when logged in' do
    subject { Ability.new(user) }

    it 'should be able to manage answer when he is the author' do
      answer.author = user
      subject.should be_able_to(:manage, answer)
    end

    it 'should not be able to manage answer when he is not the author' do
      subject.should_not be_able_to(:manage, answer)
    end

    it 'should be able to read an answer' do
      subject.should be_able_to(:read, answer)
    end

    it 'should be able to create an answer' do
      subject.should be_able_to(:create, Answer.new)
    end
  end

  context 'when admin' do
    subject { Ability.new(user) }
    before { user.update_attributes(core_role: 1) }

    it 'should be able to manage any answer' do
      subject.should be_able_to(:manage, answer)
    end
  end
end