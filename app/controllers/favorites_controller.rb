# encoding: utf-8

class FavoritesController < ApplicationController
  helper :formatting

  def index
    @user = current_user
    @user_apps_associations = assign_user_app_associations.page(params[:page])
    @favorite_apps_count = @user.apps.size
    @favorite_apps_filters = Category.filters_on @user.apps.includes(:categories)
    @favorite_apps_filters_counter = Category.count_filters_on @favorite_apps_filters
    @filter = params.fetch(:filter, [])
  end

  def create
    current_user.apps << App.find(params[:app_id])
    redirect_to action: "index"
  end

  def destroy
    UserAppAssociation.find(params[:id]).destroy
    redirect_to action: "index"
  end

  private

  def assign_user_app_associations
    if params[:filter]
      @user.user_app_associations.filter(params[:filter])
    else
      @user.user_app_associations.includes(app: [:categories, :comments])
    end
  end
end
