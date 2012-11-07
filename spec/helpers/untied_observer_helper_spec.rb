require 'spec_helper'

describe UntiedObserverHelper do

  context "When working with user" do
    let(:user) { {"user" => {id: 1, login: 'sexy_jedi_3000', first_name: 'Luke',
      last_name: 'skywalker', coisado: false}}} #Outros dados sao irrelevantes...

    describe "create_user" do
      it "should add user to database" do
        create_user(user).should == true
      end

      it 'shouldnt add user to database if missing params' do
        create_user({"user" => {login: "usuario_invalido_do_mal"}}).should == false
      end

      it 'should complete zombie user' do
        User.new(uid: 1).save(validate: false)
        create_user(user).should == true
      end
    end

    describe "update_user" do
      it "should update user in database" do
        User.create(login: "darth", first_name: "anny", last_name: "skywalker",
          uid: 1)
        update_user(user).should == true
      end
    end

    describe "destroy_user" do
      it "should erase user from database" do
        User.create(login: "darth", first_name: "anny", last_name: "skywalker",
          uid: 1)
        destroy_user(user)
        User.find_by_uid(user["user"][:id]).should be_nil
      end
    end

  end

  context "When working with environment" do
    let(:environment) {{"environment" => {name: "env", id: 3, user_id: 1}}}
    let(:environment_no_owner) {{"environment" => {id:2 , name: "Zombie Owner",
      user_id: 67 }}}

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
        create_environment(environment).should == true
      end

      it 'should create zombie user' do
        create_environment(environment_no_owner)
        User.find_by_uid(environment_no_owner["environment"][:user_id]).should_not be_nil
      end

      it 'should complete zombie environment' do
        Environment.new(eid: environment["environment"][:id]).save(validate: false) #Beware! it's a zombie
        create_environment(environment)
        Environment.find_by_eid(environment["environment"][:id]).should be_valid
      end
    end

    describe 'update_environment' do
      it 'should update environment in database' do
        Environment.create(name: "Ambiente mais lindo do mundo", eid: 3,
          owner: @user)
        update_environment(environment).should == true
      end
    end
    describe 'destroy_environment' do
      it 'should erase environment from database' do
        Environment.create(name: "Ambiente mais lindo do mundo", eid: 3,
          owner: @user)
        destroy_environment(environment)
        Environment.find_by_eid(environment["environment"][:id]).should be_nil
      end
    end
  end

  context "When working with course" do
    let(:course) {{"course" => {name: "curso", id: 1, user_id: 1,
      environment_id: 1}}}

    let(:homeless_course) {{"course" => {name: "chaves", id: 1,
      user_id: 1, environment_id: 57}}} #curso sownerronmnet

    let(:orphan_course) {{"course" => {name: "bruce wayne", id: 1,
      user_id: 77, environment_id: 99}}} #curso sem environment_id e user_id

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
        create_course(course).should == true
      end

      it 'should create zombie environment' do
        create_course(homeless_course)
        Environment.find_by_eid(homeless_course["course"][:environment_id]).should_not be_nil
      end

      it 'should create zombie owner and environment' do
        create_course(orphan_course)
        Environment.find_by_eid(orphan_course["course"][:environment_id]).should_not be_nil
        User.find_by_uid(orphan_course["course"][:user_id]).should_not be_nil
      end

      it 'should comple zombie course' do
        Course.new(cid: course["course"][:id]).save(validate: false) #ZOMBIE
        create_course(course)
        Course.find_by_cid(course["course"][:id]).should be_valid
      end
    end

    describe 'update_course' do
      it 'should update course in database' do
        update_course(course.merge(id: 2)).should == true
      end
    end
    describe 'destroy_course' do
      it 'Should erase course from database' do
        Course.new(cid: course["course"][:id]).save(validate: false) # o curso não precisa ser valido
        destroy_course(course)
        Course.find_by_cid(course["course"][:id]).should be_nil
      end
    end
  end

  context "When working with space" do
    let(:space) {{ "space" => { name: "Melhor espaco do mundo", id: 2,
      course_id: 1 }}}

    let(:orphan_space) {{ "space" => { name: "Espaco sem curso", id: 2,
      course_id: 23 }}}

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
        create_space(space).should == true
      end

      it 'should create zombie course' do
        create_space(orphan_space)
        Course.find_by_cid(orphan_space["space"][:course_id]).should_not be_nil
      end

      it 'should complete zombie space' do
        Space.new(sid: space["space"][:id]).save(validate: false)
        create_space(space)
        Space.find_by_sid(space["space"][:id]).should be_valid
      end
    end

    describe 'update_space' do
      it 'should udpate space in database' do
        update_space(space.merge(id: 1)).should == true
      end
    end

    describe 'destroy_space' do
      it 'should erase space from database' do
        Space.new(sid: space["space"][:id])
        destroy_space(space)
        Space.find_by_sid(space["space"][:id]).should be_nil
      end
    end
  end

  context "When working with subject" do
    let(:subject) {{ "subject" => { name: "Melhor materia do mundo ", id: 2,
      space_id: 1}}}

    let(:orphan_subject) {{ "subject" => { name: "Melhor materia do mundo", id: 2,
      space_id: 53 }}}

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
        create_subject(subject).should == true
      end

      it 'should create zombie space' do
        create_subject(orphan_subject)
        Space.find_by_sid(orphan_subject["subject"][:space_id]).should_not be_nil
      end

      it 'should complete zombie subject' do
        Subject.new(suid: subject["subject"][:id]).save(validate: false)
        create_subject(subject)
        Subject.find_by_suid(subject["subject"][:id]).should be_valid
      end
    end

    describe 'update_subject' do
      it 'should update subject in database' do
        update_subject(subject.merge(id:1)).should == true
      end
    end
    describe 'destroy_subject' do
      it 'should erase subject from database' do
        Subject.new(suid: subject["subject"][:id]).save(validate: false)
        destroy_subject(subject)
        Subject.find_by_suid(subject["subject"][:id]).should be_nil
      end
    end
  end

  context "When working with user_course_association" do

    let(:association) {{"user_course_association"=> { "updated_at" => "2012-11-06T09:18:23-02:00",
      "user_id" => 1, "role" => 2, "course_id" => 1, "token" => nil, "email" => nil,
      "id" => 1, "created_at" => "2012-11-06T09:18:23-02:00",
      "state" => "waiting" }}}
    let(:orphan_association) {{"user_course_association"=> { "updated_at" => "2012-11-06T09:18:23-02:00",
      "user_id" => 100, "role" => 2, "course_id" => 100, "token" => nil, "email" => nil,
      "id" => 123, "created_at" => "2012-11-06T09:18:23-02:00",
      "state" => "waiting" }}}

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
        create_user_course_association(association)
      end

      it 'should create zombie user and course' do
        create_user_course_association(orphan_association)
        User.find_by_uid(orphan_association["user_course_association"]['user_id']).should_not be_nil
        Course.find_by_cid(orphan_association["user_course_association"]['course_id']).should_not be_nil
      end

      it 'should complete zombie association' do
        UserCourseAssociation.new(ucaid: orphan_association["user_course_association"]['id']).save(validate: false)
        create_user_course_association(association)
        UserCourseAssociation.find_by_ucaid(orphan_association["user_course_association"]['id']).should be_valid
      end
    end

    describe 'update_user_course_association' do
      it 'should update association in database' do
        UserCourseAssociation.create()
        update_user_course_association(association)
        UserCourseAssociation.find_by_ucaid(1).role.should == :member
      end
    end
    describe 'destroy_user_course_association' do
      it 'should erase use_course_associaiton from database' do
        UserCourseAssociation.new(ucaid: 1).save(validate: false)
        destroy_user_course_association(association)
        UserCourseAssociation.find_by_ucaid(1).should be_nil
      end
    end
  end
end
