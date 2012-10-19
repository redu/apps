class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def current_user
    User.find_by_uid(session[:user_uid]) || User.last || FactoryGirl.create(:user)
  end
end
