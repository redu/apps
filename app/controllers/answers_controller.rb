class AnswersController < CommentsController

  def index
    @answers = Answer.where(in_response_to_id: params[:comment_id])
    authorize! :read, Answer

    respond_to do |format|
      format.js
    end
  end

end
