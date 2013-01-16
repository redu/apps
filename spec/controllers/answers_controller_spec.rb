# encoding: utf-8
require 'spec_helper'

describe AnswersController do
  let(:app) { FactoryGirl.create(:app) }
  let(:comment) { FactoryGirl.create(:common_comment) }
  let(:user) { FactoryGirl.create(:user) }

  describe "GET 'index'" do

    before { get :index, { app_id: app, comment_id: comment, locale: 'pt-BR' } }

    it "should assign comment which answers are being retrieved" do
      assigns(:comment).should == comment
    end

    it "should assign comment answers" do
      assigns(:answers).should == comment.answers
    end
  end
end
