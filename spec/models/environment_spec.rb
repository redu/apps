require 'spec_helper'

describe Environment do
  # ID do Environment no Redu
  it { should respond_to(:core_id) }
  it { should validate_presence_of(:core_id) }
  it { should validate_uniqueness_of(:core_id) }

  # Nome do Environment
  it { should respond_to(:name) }
  it { should validate_presence_of(:name) }

  # Usuário que criou o Environment
  it { should respond_to(:owner) }
  it { should belong_to(:owner) }
  it { should validate_presence_of(:owner) }

  # Usuários do Environment
  it { should have_many(:user_environment_associations).dependent(:destroy) }
  it { should have_many(:users).through(:user_environment_associations) }

  # Thumbnail
  it { should have_attached_file(:thumbnail) }

  # Cursos do Ambiente
  it { should have_many(:courses) }

  context  "Associations" do
    before do
      @course = FactoryGirl.create(:course)
      @course2 = FactoryGirl.create(:course)

      UserCourseAssociation.create(user: @course.owner) do |c|
        c.course_id = @course.id
        c.role = UserCourseAssociation.teacher
      end

      UserCourseAssociation.create(user: @course.owner) do |c|
        c.course_id = @course2.id
        c.role = UserCourseAssociation.member
      end # Ruído
    end

    it 'Does not Retrive environments whoose courses are not able to have apps added to them' do
      environments = Environment.with_admin_permission(@course.owner)
      environments.should_not include(@course2.environment)
    end

    it ' Retrives environments whoose courses are not able to have apps added to them' do
      environments = Environment.with_admin_permission(@course.owner)
      environments.should include(@course.environment)
    end
  end

end
