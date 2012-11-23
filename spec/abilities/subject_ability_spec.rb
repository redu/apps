require 'spec_helper'
require 'cancan/matchers'

describe 'Subject Ability' do
  let(:user) { FactoryGirl.create(:user)}

  context 'when not logged in' do
    subject { Ability.new(nil) }

    it 'should not be able to create subject' do
      subject.should_not be_able_to(:create, Subject.new)
    end
  end

  context 'when logged in' do
    subject { Ability.new(user) }

    before do
      @space = FactoryGirl.create(:space)
      @association = UserCourseAssociation.create(user: user) do |uca|
        uca.course_id = @space.course.id
        uca.role = UserCourseAssociation.environment_admin
      end
    end

    context 'when user has admin rights' do

      it 'should be able to create a subject' do
        subject.should be_able_to(:create,
          FactoryGirl.build(:subject, space: @space))
      end
    end

    context 'when user does not have admin rights' do

      it 'should not be able to create a subject' do
        @association.role = UserCourseAssociation.member #Membro
        @association.save

        subject.should_not be_able_to(:create,
          FactoryGirl.build(:subject, space: @space))
      end
    end
  end
end