
class UserSessionsController < ApplicationController
  skip_authorization_check

  def create
    @user_session = UserSession.new(params[:user_session])
    @valid_credentials = @user_session.save

    respond_to do |format|
      format.js
    end
  end

  def destroy
    current_user_session.destroy

    respond_to do |format|
      format.js
    end
  end
end
