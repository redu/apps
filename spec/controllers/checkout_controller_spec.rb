require 'spec_helper'

describe CheckoutController do
  before(:each) do
    @app = FactoryGirl.create(:app)
    @user = FactoryGirl.create(:user)
    controller.stub(current_user: @user)
    @params = {app_id: @app.id, locale: 'pt-BR'}
  end

  context 'when geting new' do
    it "should render step1" do
      get :new, @params
      should render_template(:step1)
    end
  end

  context 'when posting update' do
    before(:each) do
      @env = Environment.create(name: "A",
        eid: 2) { |e| e.owner = User.last }
      @env.users << User.last
      @course = Course.create(name: "c",
        cid: 9) do |c|
        c.owner = User.last
        c.environment = @env
      end
      @env.courses << @course
      @space = Space.create(name: "espaco",
        sid: 231) { |s| s.course = @course }

      @subject = Subject.create(name: "subject",
        suid: 75) { |s| s.space = @space }
    end
    context 'after step 1' do
      it 'should render step 2' do
        post :update, @params.merge(space_id: @space.id, step: 2)
        should render_template(:step2)
      end

      it 'should not render step 2 if space_id missing' do
        lambda { post :update,
          @params.merge(step: 2) }.should raise_error("Invalid State")
      end
    end
    context 'after step 2' do
      it 'should render step 3' do
        post :update, @params.merge(space_id: @space.id, create_module: false,
          next_step: 4, step: 3)
        should render_template(:step3)
      end
      it 'should not render step 3 if missing params' do
        lambda { post :update,
          @params.merge(step: 3) }.should raise_error("Invalid State")
      end
    end
    context 'after step 3' do
      it 'should create lecture on existing module' do
        post :update, @params.merge(step: 4, space_id: @space.id,
          create_module: false, lesson: "Nova Aula!", subject: @subject.id)
        Lecture.last.subject.should == @subject
      end
      it 'should create lecture on new module' do
        post :update, @params.merge(step: 4, space_id: @space.id,
          create_module: 'true', lesson: "Nova Aula!", subject: "Novo modulo")
        Lecture.last.subject.name.should == "Novo modulo"
      end

      it 'should raise error if missing params' do
        lambda { post :update,
          @params.merge(step: 4) }.should raise_error("Invalid State")
      end
    end
  end
end
