# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization

  helper_method :current_user_session, :current_user

  rescue_from CanCan::AccessDenied do |exception|
    session[:return_to] ||= request.fullpath

    flash[:notice] = t :you_do_not_have_access

    if request.xhr?
      render js: "window.location.pathname='#{root_path}';"
    else
      redirect_to root_path
    end
  end

  private
  def current_user_session
    @current_user_session ||= UserSession.find
  end

  def current_user
    @current_user ||= current_user_session && current_user_session.user
  end
end
