class FavoritesController < ApplicationController
   def index
      @user = User.find(params[:user_id])
      @apps = @user.apps.paginate(:page => params[:page])
   end

   def create
      user = User.find(params[:user_id])
      user.apps = user.apps | [App.find(params[:app_id])]
      redirect_to :action => "index"
   end
end