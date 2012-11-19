# encoding: utf-8
class CommentsController < ApplicationController

  before_filter :check_permission
  skip_before_filter :check_permission, only: [:show, :destroy]

  def show
    @comment = Comment.includes(:answers).find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def create
    @app = App.find(params[:app_id])
    @comment = if params[:comment_id]
      create_answer
    else
      create_comment
    end

    redirect_to app_path(@app)
  end

  def destroy
    Comment.find(params[:id]).destroy

    redirect_to app_path(App.find(params[:app_id]))
  end

  private

  def create_comment
    @app.comments.create(params[:comment].
      merge(author: User.find(params[:comment][:author])))
  end

  def create_answer
    @app.comments <<
      Comment.find(params[:comment_id]).answers.
        create(params[:comment].merge(author: User.find(params[:comment][:author])))
  end

  def check_permission
    unless params[:comment][:author].to_i == current_user.id
      redirect_to :back, notice: "Permissão negada"
    end
  end
end
