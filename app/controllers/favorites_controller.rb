# encoding: utf-8

class FavoritesController < ApplicationController
  helper :formatting

  def index
    @user = User.find_by_login(params[:user_id])
    authorize! :manage, @user

    @apps = @user.apps.includes(:categories, :comments)
    @favorite_apps_count = @apps.length
    @favorite_apps_filters = Category.filters_on @apps
    @favorite_apps_filters_counter = Category.count_filters_on @favorite_apps_filters
    @filter = params.fetch(:filter, [])
    @apps = filter_and_paginate_apps
  end

  def create
    @user = User.find_by_login(params[:user_id])
    @app = App.find(params[:app_id])
    @user_app_association = UserAppAssociation.new(app: @app)
    @user_app_association.user = @user
    authorize! :create, @user_app_association

    @user_app_association.save
    redirect_to action: "index"
  end

  def destroy
    @user_app_association = UserAppAssociation.find(params[:id])
    authorize! :destroy, @user_app_association

    @user_app_association.destroy
    redirect_to action: "index"
  end

  private

  def filter_and_paginate_apps
    if params[:filter]
      @apps = @apps.filter(params[:filter])
    end

    Kaminari.paginate_array(@apps).page(params[:page])
  end
end
