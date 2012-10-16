class FavoritesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @apps = @user.apps.paginate(:page => params[:page])
  end

  def create
    user = User.find(params[:user_id])
    user.apps << [App.find(params[:app_id])]
    redirect_to :action => "index"
  end

  def destroy
    user_id = params[:user_id]
    app_id = params[:id]
    association = UserAppAssociation.find_by_user_id_and_app_id(user_id, app_id)
    association.destroy
    redirect_to :action => "index"
  end
end