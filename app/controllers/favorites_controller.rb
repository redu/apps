# encoding: utf-8

class FavoritesController < ApplicationController
  helper :formatting

  def index
    @apps = current_user.apps.includes(:categories, :comments)
    @favorite_apps_count = @apps.length
    @favorite_apps_filters = Category.filters_on @apps
    @favorite_apps_filters_counter = Category.count_filters_on @favorite_apps_filters
    @filter = params.fetch(:filter, [])
    @apps = filter_and_paginate_apps
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

  def filter_and_paginate_apps
    if params[:filter]
      @apps = @apps.filter(params[:filter])
    end

    Kaminari.paginate_array(@apps).page(params[:page])
  end
end
