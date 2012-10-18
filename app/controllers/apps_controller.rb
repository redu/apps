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
    @app.update_attribute(:views, @app.views + 1)
    @user = User.last || FactoryGirl.create(:user) # TODO strip this out
    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @app }
    end
  end

  def preview
    @app = App.find(params[:id])
  end
end
