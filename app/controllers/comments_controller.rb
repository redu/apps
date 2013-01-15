# encoding: utf-8
class CommentsController < ApplicationController
  def create
    @app = App.find(params[:app_id])
    @comment = Comment.new(params[:comment].
      merge(author: User.find(params[:comment][:author])))
    @comment.app = @app

    authorize! :create, @comment
    authorize! :manage, @comment.author

    @app.comments << @comment

    redirect_to app_path(@app)
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment

    @comment.destroy
    redirect_to app_path(App.find(params[:app_id]))
  end
end
