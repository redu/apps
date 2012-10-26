require 'spec_helper'

describe UntiedObserverHelper do
  context "When working with user" do
    let(:user) { {id: 1, login: 'sexy_jedi_3000', first_name: 'Luke',
      last_name: 'skywalker', coisado: false}} #Outros dados sao irrelevantes...

    describe "create_user" do
      it "should add user to database" do
        create_user(user).should == true
      end

      it 'shouldnt add user to database if missing params' do
        create_user({login: "usuario_invalido_do_mal"}).should == false
      end
    end

    describe "update_user" do
      it "should update user in database" do
        User.create(login: "darth", first_name: "anny", last_name: "skywalker",
          uid: 1)
        update_user(user).should == true
      end
    end
  end

  context "When working with environment" do
    let(:environment) {{name: "env", id: 3, owner: 20}}
    describe 'create_environment' do
      it 'should add environment to database' do
        create_environment(environment)
        debugger
      end
    end
  end

  context "When working with course" do
  end

  context "When working with space" do
  end

  context "When working with subject" do
  end
end