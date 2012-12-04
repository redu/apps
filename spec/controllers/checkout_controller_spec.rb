# encoding: utf-8

require 'spec_helper'

describe CheckoutController do
  before(:each) do
    @app = FactoryGirl.create(:app)
    @user = FactoryGirl.create(:user)
    controller.stub(current_user: @user)
    @params = {app_id: @app.id, locale: 'pt-BR'}
  end

  describe '#update' do
   # before(:each) do
   #   @env = Environment.create(name: "A",
   #     core_id: 2) { |e| e.owner = User.last }
   #   @env.users << User.last
   #   @course = Course.create(name: "c",
   #     core_id: 9) do |c|
   #     c.owner = User.last
   #     c.environment = @env
   #   end

   #   UserCourseAssociation.create(user: @user) do |uca|
   #     uca.course = @course
   #     uca.role = UserCourseAssociation.teacher
   #   end # O user tem que estar matriculado em um curso

   #   @env.courses << @course
   #   @space = Space.create(name: "espaco",
   #     core_id: 231) { |s| s.course = @course }

   #   @subject = Subject.create(name: "subject",
   #     core_id: 75) { |s| s.space = @space }
   # end

    context 'with ?previous_step=0' do
      context 'with valid params' do
        before do
          Environment.
            stub(:with_admin_permission).and_return([double('Environment')])
        end

        it 'assigns next_step variable properly' do
          post :update, @params.merge(previous_step: 0)
          assigns(:next_step).to_i.should == 2
        end

        it 'assigns environments variable' do
          post :update, @params.merge(previous_step: 0)
          assigns(:environments).should == Environment.with_admin_permission(@user)
        end
      end

      context 'without valid params' do
        it 'does not render step2' do
          expect {
            post :update, @params.merge(step: 1)
          }.to raise_error 'Invalid State'
        end
      end
    end

    context 'with ?previous_step=1' do
      it 'assigns app_id variable' do
        post :update, @params.merge(previous_step: 1)
        assigns(:app_id).to_i.should == @app.id
      end

      it 'assigns next_step variable properly' do
        post :update, @params.merge(previous_step: 1)
        assigns(:next_step).to_i.should == 2
      end
    end

    context 'with ?step=2' do
      context 'with valid request' do
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

      context 'without valid params' do
        it 'does not render step2' do
          expect {
            post :update, @params.merge(step: 2)
          }.to raise_error 'Invalid State'
        end
      end
    end

    context 'with ?step=3' do
      context 'with valid params' do
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

      context 'whitout valid params' do
        it 'does not render step 3' do
          expect {
            post :update, @params.merge(step: 3)
          }.to raise_error "Invalid State"
        end
      end
    end

    context 'with ?step=4' do
      let(:lecture_name) { "Nova Aula" }
      let(:subject_name) { "Novo módulo" }

      context 'valid params' do
        context 'when creating lecture in existing subject' do
          before do
            stub_request(:post, ReduApps::Application.config.api_url +
                                Lecture.post_to_api_url(@subject.core_id)).
              to_return(status: 201, body: { name: lecture_name, id: 713,
                links: [{ rel: 'self_link',
                          href: 'http://www.redu.com.br/espacos/1/modulos/1/aulas/1-class'}] }.to_json)
            post :update,
                 @params.merge(step: 4, space_id: @space.id, create_subject: 'false',
                               lecture: lecture_name, subject: @subject.id)
          end

          it_behaves_like 'a checkout variables ascriber'
        end

        context 'when creating lecture in new subject' do
          before do
            new_redu_subject_id = 713
            stub_request(:post, ReduApps::Application.config.api_url +
                                Subject.post_to_api_url(@space.core_id)).
              to_return(status: 201,
                        body: { name: subject_name, id: new_redu_subject_id }.to_json )
            stub_request(:post, ReduApps::Application.config.api_url +
                                Lecture.post_to_api_url(new_redu_subject_id)).
              to_return(status: 201, body: { name: lecture_name, id: 713,
                links: [{ rel: 'self_link',
                          href: 'http://www.redu.com.br/espacos/1/modulos/1/aulas/1-class'}] }.to_json)
            post :update,
                 @params.merge(step: 4, space_id: @space.id, create_subject: 'true',
                               lecture: lecture_name, subject: subject_name)
          end

          it_behaves_like 'a checkout variables ascriber'
        end

        context 'when redu API returns Unauthorized status code' do
          before do
            stub_request(:post, ReduApps::Application.config.api_url +
                                Subject.post_to_api_url(@space.core_id)).
              to_return(status: 401)
            post :update,
                 @params.merge(step: 4, space_id: @space.id, create_subject: 'true',
                               lecture: lecture_name, subject: subject_name)
          end

          it 'should set flash error message' do
            flash[:error].should == "Você não está autorizado a adicionar o aplicativo a esta disciplina."
          end
        end

        context 'when redu API returns BadRequest status code' do
          before do
            stub_request(:post, ReduApps::Application.config.api_url +
                                Subject.post_to_api_url(@space.core_id)).
              to_return(status: 422)
            post :update,
                 @params.merge(step: 4, space_id: @space.id, create_subject: 'true',
                               lecture: lecture_name, subject: subject_name)
          end

          it 'should set flash error message' do
            flash[:error].should == "Por favor, verifique os campos preenchidos."
          end
        end
      end

      context 'without valid params' do
        it 'should raise error if missing params' do
          expect {
            post :update, @params.merge(step: 4)
          }.to raise_error "Invalid State"
        end
      end
    end
  end # describe 'POST update'
end
