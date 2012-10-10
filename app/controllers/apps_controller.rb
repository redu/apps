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

  def show
    @app = App.find(params[:id])

    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @app }
    end
  end
end
