# encoding: utf-8
require 'spec_helper'

describe AnswersController do
  let(:app) { FactoryGirl.create(:app) }
  let(:comment) { FactoryGirl.create(:common_comment) }
  let(:user) { FactoryGirl.create(:user) }

  describe "GET 'index'" do

    before { get :index, { app_id: app, comment_id: comment, locale: 'pt-BR' } }

    it "should assign comment answers" do
      assigns(:answers).should == comment.answers
    end
  end

  describe "POST 'create'" do

    before do
      controller.stub(current_user: user)
      @params = { app_id: app, comment_id: comment, answer: {
          author: user.id, body: "Olá! Parabéns pelo REA." },
          locale: 'pt-BR'
        }
    end

    it "should create a new comment, which is actually an answer" do
      expect {
        post :create, @params
      }.to change(Comment, :count).by(1)
    end

    it "should create a new answer for proper comment" do
      expect {
        post :create, @params
      }.to change(comment.answers, :count).by(1)
    end

    it "should set answer author properly" do
      expect {
        post :create, @params
      }.to change(user.comments, :count).by(1)
    end
  end

  describe "POST 'destroy'" do
    before do
      controller.stub(current_user: user)
      comment.answers.first.update_attributes(author: user) # autorização
      @params = { app_id: app, comment_id: comment, id: comment.answers.first,
                  locale: 'pt-BR' }
    end

    it "should destroy answer" do
      expect {
        post :destroy, @params
      }.to change(Comment, :count).by(-1)
    end

    it "should destroy answer associated with proper comment" do
      expect {
        post :destroy, @params
      }.to change(comment.answers, :count).by(-1)
    end

    it "should destroy answer associated with proper user" do
      expect {
        post :destroy, @params
      }.to change(user.comments, :count).by(-1)
    end
  end

end
