require 'spec_helper'
require 'cancan/matchers'

describe 'Space ability' do
  let(:user) { FactoryGirl.create(:user) }
  let(:space) { FactoryGirl.create(:space) }

  context 'when not logged in' do
    subject { Ability.new(nil) }

    it 'should not be able to manage a space' do
      subject.should_not be_able_to(:manage, space)
    end
  end

  context 'when logged in' do
    subject { Ability.new(user) }

    context 'when managing' do
      it 'should be able to manage a space if he is a environment_admin' do
        FactoryGirl.create(:user_course_association, course: space.course,
                           user: user, role: :environment_admin)
        subject.should be_able_to(:manage, space)
      end

      it 'should be able to manage a space if he is a teacher' do
        FactoryGirl.create(:user_course_association, course: space.course,
                           user: user, role: :teacher)
        subject.should be_able_to(:manage, space)
      end

      it 'should not be able to manage a space if he is a member' do
        FactoryGirl.create(:user_course_association, course: space.course,
                           user: user, role: :member)
        subject.should_not be_able_to(:manage, space)
      end

      it 'should not be able to manage a space if he is a tutor' do
        FactoryGirl.create(:user_course_association, course: space.course,
                           user: user, role: :tutor)
        subject.should_not be_able_to(:manage, space)
      end
    end
  end
end
