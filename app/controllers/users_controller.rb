class UsersController < ApplicationController
  def favorites
    user = User.find(params[:user_id])
    @apps = user.apps.paginate(:page => params[:page])
  end
end
