class AppsController < ApplicationController
   def index
      @categories = Category.all
      @apps = App.filter_by_categories(params[:filter])
      @apps = @apps.page(params[:page])
      @filter = params.fetch(:filter, [])
      debugger
      respond_to do |format|
        format.js {}
        format.html
      end
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
