class FavoritesController < ApplicationController
  def index
    @user_apps_associations = current_user.user_app_associations.page(params[:page])
  end

  def create
    current_user.apps << App.find(params[:app_id])
    redirect_to action: "index"
  end

  def destroy
    association = UserAppAssociation.find(params[:id])
    association.destroy
    redirect_to action: "index"
  end
end
