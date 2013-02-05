# encoding: utf-8
class CommentsController < ApplicationController

  def index
    @app = App.find(params[:app_id])
    authorize! :show, App

    @comments = Kaminari::paginate_array(@app.comments.common.order('created_at DESC')).
      page(params[:page]).per(comments_per_page)

    respond_to do |format|
      format.js
    end
  end

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

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment

    @comment.destroy

    respond_to do |format|
      format.js
    end
  end

  private

  def comments_per_page
    ReduApps::Application.config.comments_per_page
  end
end
