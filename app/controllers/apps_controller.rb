class AppsController < ApplicationController
   def index
      filter = params[:filter]
      if filter
         @apps = App.joins(:categories).where(:categories => {:name => filter})
      else
         @apps = App
      end
      @apps = @apps.paginate(:page => params[:page])
   end
end