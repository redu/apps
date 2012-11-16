# encoding: utf-8

require 'spec_helper'

describe CheckoutController do
  before(:each) do
    @app = FactoryGirl.create(:app)
    @user = FactoryGirl.create(:user)
    @params = { app_id: @app.id, locale: 'pt-BR' }
  end

  describe 'POST update' do
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

    it 'assigns app_id variable' do
      post :update, @params
      assigns(:app_id).to_i.should == @app.id
    end

    it 'assigns next_step variable properly' do
      post :update, @params
      assigns(:next_step).to_i.should == 2
    end

    context 'after step 1' do

      context 'when performing a valid request' do
        before do
          post :update, @params.merge(space_id: @space.id, step: 2,
                                      previous_step: 1)
        end

        it 'assigns next_step variable properly' do
          assigns(:next_step).to_i.should == 3
        end

        it 'assigns space_id variable' do
          assigns(:space_id).to_i.should == @space.id
        end
      end

      it 'should not render step 2 if space_id missing' do
        expect {
          post :update, @params.merge(step: 2)
        }.to raise_error "Invalid State"
      end
    end

    context 'after step 2' do

      context 'when performing a valid request' do
        before do
          post :update, @params.merge(space_id: @space.id, create_subject: false,
                                      next_step: 4, step: 3, previous_step: 2)
        end

        it 'assigns space_id variable' do
          assigns(:space_id).to_i.should == @space.id
        end

        it 'assigns create_subject variable' do
          assigns(:create_subject).should be_false
        end
      end

      it 'should not render step 3 if missing params' do
        expect {
          post :update, @params.merge(step: 3)
        }.to raise_error "Invalid State"
      end
    end

    context 'after step 3' do

      context 'when creating lecture in existing subject' do
        before do
          lecture_name = "Nova Aula"
          stub_request(:post, ReduApps::Application.config.api_url +
                              Lecture.post_to_api_url(@subject.suid)).
            to_return(status: 201, body: { name: lecture_name, id: 713 }.to_json)
          post :update,
               @params.merge(step: 4, space_id: @space.id, create_subject: 'false',
                             lecture: lecture_name, subject: @subject.id)
        end

        it_behaves_like 'a checkout variables ascriber'
      end

      context 'when creating lecture in new subject' do
        before do
          subject_name = "Novo módulo"
          lecture_name = "Nova Aula"
          new_redu_subject_id = 713
          stub_request(:post, ReduApps::Application.config.api_url +
                              Subject.post_to_api_url(@space.sid)).
            to_return(status: 201,
                      body: { name: subject_name, id: new_redu_subject_id }.to_json )
          stub_request(:post, ReduApps::Application.config.api_url +
                              Lecture.post_to_api_url(new_redu_subject_id)).
            to_return(status: 201, body: { name: lecture_name, id: 713 }.to_json)
          post :update,
               @params.merge(step: 4, space_id: @space.id, create_subject: 'true',
                             lecture: lecture_name, subject: subject_name)
        end

        it_behaves_like 'a checkout variables ascriber'
      end

      it 'should raise error if missing params' do
        expect {
          post :update, @params.merge(step: 4)
        }.to raise_error "Invalid State"
      end
    end # context 'after step 3'
  end # describe 'POST update'
end
