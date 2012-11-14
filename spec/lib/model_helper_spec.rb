require 'spec_helper'
describe ModelHelper do
  let(:user) { {"uid"=> 22, 'login' => 'sexy_jedi_3000',
      'first_name' => 'Luke', 'last_name' => 'skywalker'}}

  before(:all) do
    @model_helper = ModelHelper.new(ReduApps::Application.config.untied['model_data']['User'])
    @user = FactoryGirl.create(:user, uid: 1)
  end

  after(:all) do
    @user.destroy
  end

  describe 'find' do

    it 'should find object by id' do
      @model_helper.find(1).should_not be_nil
    end

    it 'should not find object if it doesnt exist' do
      @model_helper.find(3333).should be_nil
    end
  end

  describe 'create_zombie' do

    it 'should create zombie model' do
      @model_helper.create_zombie(99)
      User.find_by_uid(99).should_not be_nil
    end
  end

  describe 'create_model' do

    context "with valid payload" do
      it 'should create user' do
        @model_helper.create_model(user)
        User.find_by_uid(user['uid']).should_not be_nil
      end

      it 'should update zombie user' do
        User.new(uid: user['uid']).save(validate: false)
        @model_helper.create_model(user)
        User.find_by_uid(user['uid']).should be_valid
      end
    end
  end

  describe 'update_model' do

    it 'should update model in database' do
      User.new(uid: user['uid']).save(validate: false)
      @model_helper.update_model(user)
      User.find_by_uid(user['uid']).should be_valid
    end

    it 'should create model if it doesnt exist' do
      @model_helper.update_model(user)
      User.find_by_uid(user['uid']).should be_valid
    end
  end

  describe 'destroy_model' do
    it 'should delete from database' do
      User.new(uid: user['uid']).save(validate: false)
      @model_helper.destroy_model(user)
      User.find_by_uid(user['uid']).should be_nil
    end
  end
end