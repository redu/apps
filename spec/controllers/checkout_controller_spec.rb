# encoding: utf-8

require 'spec_helper'

describe CheckoutController do
  before(:each) do
    @app = FactoryGirl.create(:app)
    @user = FactoryGirl.create(:user)
    @params = { app_id: @app.id, locale: 'pt-BR' }
  end

  context 'when geting new' do
    it "should render step1" do
      get :new, @params
      should render_template(:step1)
    end
  end

  context 'when posting update' do
    before(:each) do
      user = User.last
      environment = Environment.create(name: "Ambiente", eid: 2, owner: user)
      environment.users << user
      course = Course.create(name: "Curso", cid: 9, owner: user,
                              environment: environment)
      environment.courses << course
      @space = Space.create(name: "Disciplina", sid: 231, course: course)

      @subject = Subject.create(name: "Módulo", suid: 75, space: @space)
    end

    context 'after step 1' do
      it 'should render step 2' do
        post :update, @params.merge(space_id: @space.id, step: 2)
        should render_template(:step2)
      end

      it 'should not render step 2 if space_id missing' do
        expect { 
          post :update, @params.merge(step: 2) 
        }.to raise_error("Invalid State")
      end
    end

    context 'after step 2' do
      it 'should render step 3' do
        post :update, @params.merge(space_id: @space.id, create_subject: false,
                                    next_step: 4, step: 3)
        should render_template(:step3)
      end

      it 'should not render step 3 if missing params' do
        expect { 
          post :update,
          @params.merge(step: 3) 
        }.to raise_error("Invalid State")
      end
    end

    context 'after step 3' do
      it 'should create lecture on existing module' do
        post :update, @params.merge(step: 4, space_id: @space.id,
          create_subject: false, lesson: "Nova Aula", subject: @subject.id)
        Lecture.last.subject.should == @subject
      end

      it 'should create lecture on new module' do
        post :update, 
             @params.merge(step: 4, space_id: @space.id, create_subject: 'true',
                           lesson: "Nova Aula", subject: "Novo módulo")
        Lecture.last.subject.name.should == "Novo módulo"
      end

      it 'should raise error if missing params' do
        expect { 
          post :update,
          @params.merge(step: 4) 
        }.to raise_error("Invalid State")
      end
    end
  end
end
