class AnswersController < CommentsController

  def index
    @comment = Comment.includes(:answers).find(params[:comment_id])
    @answers = @comment.answers
    authorize! :read, Answer

    respond_to do |format|
      format.js
    end
  end

end
