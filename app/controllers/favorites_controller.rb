class FavoritesController < ApplicationController
  def index
    @user = User.find_by_login(params[:user_id])
    raise ActiveRecord::RecordNotFound unless @user
    @user_apps_associations = @user.user_app_associations.page(params[:page])
  end

  def create
    user = User.find_by_login(params[:user_id])
    raise ActiveRecord::RecordNotFound unless user
    user.apps << App.find(params[:app_id])
    redirect_to action: "index"
  end

  def destroy
    association = UserAppAssociation.find(params[:association_id])
    association.destroy
    redirect_to action: "index"
  end
end