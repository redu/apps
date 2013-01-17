# encoding: utf-8
class CommentsController < ApplicationController
  def create
    comment_params = params[:comment] || params[:answer]
    @app = App.find(params[:app_id])
    user = User.find(comment_params.delete(:author))

    @comment = Comment.new(comment_params) do |comment|
      comment.in_response_to_id = params[:comment_id].to_i
      comment.app = @app
      comment.author = user
    end

    authorize! :create, @comment
    authorize! :manage, @comment.author

    @comment.save

    redirect_to app_path(@app)
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment

    @comment.destroy
    redirect_to app_path(App.find(params[:app_id]))
  end
end
