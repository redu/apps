require 'spec_helper'
require 'cancan/matchers'

describe 'Comment ability' do
  let(:user) { FactoryGirl.create(:user) }
  let(:comment) { FactoryGirl.create(:comment) }

  context 'when not logged in' do
    subject { Ability.new(nil) }

    it 'should not be able to create an comment' do
      subject.should_not be_able_to(:create, Comment.new)
    end

    it 'should be able to read a comment' do
      subject.should be_able_to(:read, comment)
    end
  end

  context 'when logged in' do
    subject { Ability.new(user) }

    context 'when common' do
      before do
        user.update_attributes(role: :member)
      end

      it 'should be able to create a common Comment' do
        subject.should be_able_to(:create, Comment.new(type: :common))
      end

      it 'should not be able to create an specialized Comment' do
        subject.should_not be_able_to(:create, Comment.new(type: :specialized))
      end
    end

    context 'when specialist' do
      before do
        user.update_attributes(role: :specialist)
      end

      it 'should be able to create an specialized Comment' do
        subject.should be_able_to(:create, Comment.new(type: :specialized))
      end

      it 'should not be able to create a common Comment' do
        subject.should_not be_able_to(:create, Comment.new(type: :common))
      end
    end

    it 'should be able to manage comment when he is the author' do
      comment.author = user
      subject.should be_able_to(:manage, comment)
    end

    it 'should not be able to manage comment when he is not the author' do
      subject.should_not be_able_to(:manage, comment)
    end

    it 'should be able to read a comment' do
      subject.should be_able_to(:read, comment)
    end
  end
end
