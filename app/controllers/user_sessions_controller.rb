
class UserSessionsController < ApplicationController
  skip_authorization_check only: :create

  def create
    @user_session = UserSession.new(params[:user_session])
    @valid_credentials = @user_session.save

    respond_to do |format|
      format.js
    end
  end

  def destroy
    authorize! :destroy, current_user_session

    current_user_session.destroy
    # Necessário, pois o current_user foi carregado pelo CanCan
    @current_user = current_user_session.user

    respond_to do |format|
      format.js { render js: "window.location='#{path_to_be_back}';" }
    end
  end
end
