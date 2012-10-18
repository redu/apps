class AppsController < ApplicationController
   def index
      @categories = Category.all
      @apps = App.filter_by_categories(params[:filter])
      @apps = @apps.page(params[:page])
      @filter = params.fetch(:filter, [])

      respond_to do |format|
        format.js {}
        format.html
      end
   end

  def show
    @app = App.find(params[:id])
    @user = User.find(1) # Usuario para fins de teste
    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @app }
    end
  end

  def preview
    @app = App.find(params[:id])
  end
end
