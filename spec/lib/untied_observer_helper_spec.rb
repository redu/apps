require 'spec_helper'

describe UntiedObserverHelper do
  let(:helper){ UntiedObserverHelper.instance }
  context "When working with user" do

    let(:user) { {'id' => 1, 'login' => 'sexy_jedi_3000',
      'first_name' => 'Luke', 'last_name' =>  'skywalker', coisado: false}} #Outros dados sao irrelevantes...

    describe "create_user" do
      it "should add user to database" do
        helper.create_proxy("user", user).should == true
      end

      it 'shouldnt add user to database if missing params' do
        helper.create_proxy("user", {login: "usuario_invalido_do_mal"}).should == false
      end

      it 'should complete zombie user' do
        User.new(uid: 1).save(validate: false)
        helper.create_proxy("user", user).should == true
      end
    end

    describe "update_user" do

      it "should update user in database" do
        User.create(login: "darth", first_name: "anny", last_name: "skywalker",
          uid: 1)
        helper.update_proxy("user", user).should == true
      end
    end

    describe "destroy_user" do

      it "should erase user from database" do
        User.create(login: "darth", first_name: "anny", last_name: "skywalker",
          uid: 1)
        helper.destroy_proxy("user", user)
        User.find_by_uid(user[:id]).should be_nil
      end
    end
  end

  context "When working with environment" do

    let(:environment) {{"name" => "env", "id" =>  3, "user_id" => 1}}
    let(:environment_no_owner) {{"id" => 2 , "name" => "Zombie Owner",
      "user_id" => 67 }}

    before(:all) do
      @user = FactoryGirl.create(:user, uid: 1)
    end
    after(:all)  do
      @user.destroy
      FactoryGirl.reload
    end

    #context with valid user,
    describe 'create_environment' do
      it 'should add environment to database' do
        helper.create_proxy("environment", environment).should == true
      end

      it 'should create zombie user' do
        helper.create_proxy("environment", environment_no_owner)
        User.find_by_uid(environment_no_owner['user_id']).should_not be_nil
      end

      it 'should complete zombie environment' do
        Environment.new(eid: environment['id']).save(validate: false) #Beware! it's a zombie
        helper.create_proxy("environment", environment)
        Environment.find_by_eid(environment['id']).should be_valid
      end
    end

    describe 'update_environment' do

      it 'should update environment in database' do
        Environment.create(name: "Ambiente mais lindo do mundo", eid: 3,
          owner: @user)
        helper.update_proxy("environment", environment).should == true
      end
    end

    describe 'destroy_environment' do

      it 'should erase environment from database' do
        Environment.create(name: "Ambiente mais lindo do mundo", eid: 3,
          owner: @user)
        helper.destroy_proxy("environment", environment)
        Environment.find_by_eid(environment['id']).should be_nil
      end
    end
  end

  context "When working with course" do

    let(:course) {{"name" => "curso", "id" => 1, "user_id" => 1,
      "environment_id" => 1}}

    let(:homeless_course) {{"name" => "chaves", "id" => 1,
      "user_id" => 1, "environment_id" => 57}} #curso sownerronmnet

    let(:orphan_course) {{ "name" => "bruce wayne", "id" => 1,
      "user_id" => 77, "environment_id" =>  99 }} #curso sem environment_id e user_id

    before(:all) do
      @course = FactoryGirl.create(:course, cid: 2)
    end

    after(:all) do
      @course.owner.destroy
      @course.environment.owner.destroy
      @course.environment.destroy
      @course.destroy
      FactoryGirl.reload
    end

    describe "create_course" do

      it 'should add course to database' do
        helper.create_proxy("course", course).should == true
      end

      it 'should create zombie environment' do
        helper.create_proxy("course", homeless_course)
        Environment.find_by_eid(homeless_course["environment_id"]).should_not be_nil
      end

      it 'should create zombie owner and environment' do
        helper.create_proxy("course", orphan_course)
        Environment.find_by_eid(orphan_course["environment_id"]).should_not be_nil
        User.find_by_uid(orphan_course["user_id"]).should_not be_nil
      end

      it 'should comple zombie course' do
        Course.new(cid: course["id"]).save(validate: false) #ZOMBIE
        helper.create_proxy("course", course)
        Course.find_by_cid(course["id"]).should be_valid
      end
    end

    describe 'update_course' do

      it 'should update course in database' do
        helper.update_proxy("course", course.merge(id: 2)).should == true
      end
    end

    describe 'destroy_course' do

      it 'Should erase course from database' do
        Course.new(cid: course["id"]).save(validate: false) # o curso não precisa ser valido
        helper.destroy_proxy("course", course)
        Course.find_by_cid(course["id"]).should be_nil
      end
    end
  end

  context "When working with space" do

    let(:space) {{ "name" => "Melhor espaco do mundo", "id" => 2,
      "course_id" => 1 }}

    let(:orphan_space) {{ "name" => "Espaco sem curso", "id" => 2,
      "course_id" => 23 }}

    before(:all) do
      @space = FactoryGirl.create(:space)
    end

    after(:all) do
      course = @space.course
      course.owner.destroy
      course.environment.owner.destroy
      course.environment.destroy
      course.destroy
      @space.destroy
      FactoryGirl.reload
    end

    describe 'create_space' do

      it 'should add space to database' do
        helper.create_proxy("space", space).should == true
      end

      it 'should create zombie course' do
        helper.create_proxy("space", orphan_space)
        Course.find_by_cid(orphan_space["course_id"]).should_not be_nil
      end

      it 'should complete zombie space' do
        Space.new(sid: space["id"]).save(validate: false)
        helper.create_proxy("space", space)
        Space.find_by_sid(space["id"]).should be_valid
      end
    end

    describe 'update_space' do

      it 'should udpate space in database' do
        helper.update_proxy("space", space.merge(id: 1)).should == true
      end
    end

    describe 'destroy_space' do

      it 'should erase space from database' do
        Space.new(sid: space["id"])
        helper.destroy_proxy("space", space)
        Space.find_by_sid(space["id"]).should be_nil
      end
    end
  end

  context "When working with subject" do

    let(:subject) {{ "name" => "Melhor materia do mundo ", "id" => 2,
      "space_id" => 1}}

    let(:orphan_subject) {{ "name" => "Melhor materia do mundo", "id" => 2,
      "space_id" => 53 }}

    before(:all) do
      @subject = FactoryGirl.create(:subject)
    end

    after(:all) do #ISSO TA FEIO DEMAIS
      course = @subject.space.course
      course.owner.destroy
      course.environment.owner.destroy
      course.environment.destroy
      course.destroy
      @subject.space.destroy
      @subject.destroy
      FactoryGirl.reload
    end

    describe 'create_subject' do

      it 'should add subject to database' do
        helper.create_proxy("subject", subject).should == true
      end

      it 'should create zombie space' do
        helper.create_proxy("subject", orphan_subject)
        Space.find_by_sid(orphan_subject["space_id"]).should_not be_nil
      end

      it 'should complete zombie subject' do
        Subject.new(suid: subject["id"]).save(validate: false)
        helper.create_proxy("subject", subject)
        Subject.find_by_suid(subject["id"]).should be_valid
      end
    end

    describe 'update_subject' do

      it 'should update subject in database' do
        helper.update_proxy("subject", subject.merge("id" => 1)).should == true
      end
    end

    describe 'destroy_subject' do

      it 'should erase subject from database' do
        Subject.new(suid: subject["id"]).save(validate: false)
        helper.destroy_proxy("subject", subject)
        Subject.find_by_suid(subject["id"]).should be_nil
      end
    end
  end

  context "When working with user_course_association" do

    let(:association) {{ "updated_at" => "2012-11-06T09:18:23-02:00",
      "user_id" => 1, "role" => 2, "course_id" => 1, "token" => nil, "email" => nil,
      "id" => 1, "created_at" => "2012-11-06T09:18:23-02:00",
      "state" => "waiting" }}
    let(:orphan_association) {{ "updated_at" => "2012-11-06T09:18:23-02:00",
      "user_id" => 100, "role" => 2, "course_id" => 100, "token" => nil, "email" => nil,
      "id" => 123, "created_at" => "2012-11-06T09:18:23-02:00",
      "state" => "waiting" }}

    before(:all) do
      @course = FactoryGirl.create(:course)
    end

    after(:all) do
      @course.owner.destroy
      @course.environment.owner.destroy
      @course.environment.destroy
      @course.destroy
      FactoryGirl.reload
    end

    describe 'create_user_course_association' do

      it 'should add association to database' do
        helper.create_proxy("user_course_association", association)
      end

      it 'should create zombie user and course' do
        helper.create_proxy("user_course_association", orphan_association)
        User.find_by_uid(orphan_association['user_id']).should_not be_nil
        Course.find_by_cid(orphan_association['course_id']).should_not be_nil
      end

      it 'should complete zombie association' do
        UserCourseAssociation.new(ucaid: orphan_association['id']).save(validate: false)
        helper.create_proxy("user_course_association", association)
        UserCourseAssociation.find_by_ucaid(orphan_association['id']).should be_valid
      end
    end

    describe 'update_user_course_association' do

      it 'should update association in database' do
        UserCourseAssociation.create()
        helper.update_proxy("user_course_association", association)
        UserCourseAssociation.find_by_ucaid(1).role.should == :member
      end
    end

    describe 'destroy_user_course_association' do

      it 'should erase use_course_associaiton from database' do
        UserCourseAssociation.new(ucaid: 1).save(validate: false)
        helper.destroy_proxy("user_course_association", association)
        UserCourseAssociation.find_by_ucaid(1).should be_nil
      end
    end
  end
end
