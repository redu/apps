class AnswersController < ApplicationController
  def index
    @comment = Comment.includes(:answers).find(params[:comment_id])
    @answers = @comment.answers
    authorize! :read, Answer

    respond_to do |format|
      format.js
    end
  end

  def create
    app = App.find(params[:app_id])
    comment = Comment.find(params[:comment_id])
    authorize! :create, comment

    answer = Comment.new(params[:answer].
      merge(author: User.find(params[:answer][:author])))
    answer.app = app
    comment.answers << answer

    redirect_to app_path(app)
  end

  def destroy
    comment = Comment.find(params[:id])
    authorize! :destroy, comment

    comment.destroy
    redirect_to app_path(App.find(params[:app_id]))
  end
end
