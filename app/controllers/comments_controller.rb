class CommentsController < ApplicationController
  def create
    @app = App.find(params[:app_id])
    #TODO autor do comentário deve ser o usuário da sessão (buscando por login)
    params[:comment][:author] = User.find_by_login(params[:comment][:author])
    @comment = @app.comments.create(params[:comment])
    redirect_to app_path(@app)
  end

  def destroy
    @app = App.find(params[:app_id])
    @comment = @app.comments.find(params[:id])
    @comment.destroy
    redirect_to app_path(@app)
  end
end
