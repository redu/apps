class CommentsController < ApplicationController
  def create
    @app = App.find(params[:app_id])
    #TODO autor do comentário deve ser o usuário da sessão (buscando por login)
    params[:comment][:author] = User.find_by_login(params[:comment][:author])
    @comment = if params[:comment_id]
        @app.comments <<
          Comment.find(params[:comment_id]).answers.create(params[:comment])
      else
        @app.comments.create(params[:comment])
      end
    redirect_to app_path(@app)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to app_path(App.find(params[:app_id]))
  end
end
