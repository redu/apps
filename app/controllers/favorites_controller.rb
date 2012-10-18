class FavoritesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @user_apps_association = @user.user_app_associations.paginate(:page => params[:page])
  end

  def create
    user = User.find(params[:user_id])
    user.apps << App.find(params[:app_id])
    redirect_to :action => "index"
  end

  def destroy
    association = UserAppAssociation.find(params[:association_id])
    association.destroy
    redirect_to :action => "index"
  end
end