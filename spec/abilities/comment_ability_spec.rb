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

    context 'a common user' do
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

    context 'a specialist' do
      before do
        user.update_attributes(role: :specialist)
      end

      it 'should be able to create an specialized Comment' do
        subject.should be_able_to(:create, Comment.new(type: :specialized))
      end

      it 'should be able to create a common Comment' do
        subject.should be_able_to(:create, Comment.new(type: :common))
      end
    end

    context 'an admin' do
      before do
        user.update_attributes(core_role: 1)
      end

      it 'should be able to create a common Comment' do
        subject.should be_able_to(:create, Comment.new(type: :common))
      end

      it 'should be able to create an specialized Comment' do
        subject.should be_able_to(:create, Comment.new(type: :specialized))
      end

      context 'who is not the comment author' do
        it 'should still be able to manage comment' do
          subject.should be_able_to(:manage, comment)
        end
      end
    end

    context 'as the comment author user' do
      it 'should be able to manage comment' do
        comment.author = user
        subject.should be_able_to(:manage, comment)
      end
    end

    context 'as another user than the comment author user' do
      it 'should not be able to manage comment' do
        subject.should_not be_able_to(:manage, comment)
      end
    end

    it 'should be able to read a comment' do
      subject.should be_able_to(:read, comment)
    end
  end
end
