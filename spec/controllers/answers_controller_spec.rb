# encoding: utf-8
require 'spec_helper'

describe AnswersController do
  let(:app) { FactoryGirl.create(:app) }
  let(:comment) { FactoryGirl.create(:common_comment) }
  let(:user) { FactoryGirl.create(:user) }

  describe "GET 'index'" do
    before do
      get :index,
          { app_id: app, comment_id: comment, locale: 'pt-BR', format: 'js' }
    end

    it "should assign comment answers" do
      assigns(:answers).should == Answer.where(in_response_to_id: comment.id)
    end

    it "should respond with 200 status code" do
      response.status.should == 200
    end
  end
end
