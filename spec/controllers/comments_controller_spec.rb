require 'spec_helper'

describe CommentsController do
  describe "POST create" do
    before do
      @app = FactoryGirl.create(:app)
    end

    context "when creating a comment" do
      before do
        @user = FactoryGirl.create(:member)
        @params = { :app_id => @app, :comment => {
            :author => @user.login, :body => "Ola! Parabens pelo REA." },
            :locale => 'pt-BR'
          }
      end

      context "with valid params" do
        it 'should create a new comment' do
          expect {
            post :create, @params
          }.to change(Comment, :count).by(1)
        end

        it 'should create a new common comment' do # common is the default type
          expect {
            post :create, @params
          }.to change(Comment.common, :count).by(1)
        end

        it 'should associate new comment with proper app' do
          expect {
            post :create, @params
          }.to change(@app.comments, :count).by(1)
        end

        it 'should associate new comment with proper user' do
          expect {
            post :create, @params
          }.to change(@user.comments, :count).by(1)
        end

        it 'should assign app' do
          post :create, @params
          assigns(:app).should == @app
        end

        it 'should assign comment' do
          post :create, @params
          assigns(:comment).should_not be_nil
        end

        it 'should assign comment with proper author' do
          post :create, @params
          assigns(:comment).author.should == @user
        end

        it 'should assign comment with proper body' do
          post :create, @params
          assigns(:comment).body.should == @params[:comment][:body]
        end

        context "which is common" do
          before do
            @user = FactoryGirl.create(:member)
            @params = {:app_id => @app, :comment => {
                :author => @user.login, :body => "Ola! Parabens pelo REA.",
                :type => :common },
                :locale => 'pt-BR'
              }
          end

          it 'should create a new common comment' do
            expect {
              post :create, @params
            }.to change(Comment.common, :count).by(1)
          end

          it 'should not create a new specialized comment' do
            expect {
              post :create, @params
            }.to_not change(Comment.specialized, :count).by(1)
          end
        end # "which is common"

        context "which is specialized" do
          before do
            @user = FactoryGirl.create(:specialist)
            @params = {:app_id => @app, :comment => {
                :author => @user.login, :body => "Ola! Parabens pelo REA.",
                :type => :specialized },
                :locale => 'pt-BR'
              }
          end

          it 'should create a new specialized comment' do
            expect {
              post :create, @params
            }.to change(Comment.specialized, :count).by(1)
          end

          it 'should not create a new common comment' do
            expect {
              post :create, @params
            }.to_not change(Comment.common, :count).by(1)
          end
        end # "which is specialized"
      end # context "with valid params"
    end # context "when creating a comment"
  end

  describe "DELETE destroy" do
    context "with valid params" do
      before do
        @app = FactoryGirl.create(:app)
        @user = FactoryGirl.create(:specialist)
        @comment = FactoryGirl.create(:specialized_comment, :author => @user,
                                      :app => @app)
        @params = { :app_id => @app.id, :id => @comment.id, :locale => 'pt-BR'}
      end

      it 'should destroy one comment' do
        expect {
          post :destroy, @params
        }.to change(Comment, :count).by(-1)
      end

      it 'should destroy one comment from proper app' do
        expect {
          post :destroy, @params
        }.to change(@app.comments, :count).by(-1)
      end

      it 'should destroy one comment from proper user' do
        expect {
          post :destroy, @params
        }.to change(@user.comments, :count).by(-1)
      end
    end
  end
end
