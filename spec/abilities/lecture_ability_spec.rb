require 'spec_helper'
require 'cancan/matchers'

describe 'Lecture Ability' do
  let(:user) { FactoryGirl.create(:user) }

  context 'when not logged in' do
    subject { Ability.new(nil) }

    it 'should not be able to create lecture' do
      subject.should_not be_able_to(:create, Lecture.new)
    end
  end

  context 'when logged in' do
    subject { Ability.new(user) }

    before do
      @subject = FactoryGirl.create(:subject)
      @association = UserCourseAssociation.create(user: user) do |uca|
        uca.course_id = @subject.space.course.id
        uca.role = UserCourseAssociation.environment_admin
      end
      @lecture = FactoryGirl.build(:lecture, subject: @subject)
    end

    context 'with admin rights' do
      it 'should be able to create a lecture' do
        subject.should be_able_to(:create, @lecture)
      end
    end

    context 'without admin rights' do
      it 'should not be to create a lecture' do
        @association.role = UserCourseAssociation.member
        @association.save
        subject.should_not be_able_to(:create, @lecture)
      end
    end
  end
end