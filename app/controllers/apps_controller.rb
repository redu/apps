class AppsController < ApplicationController
  def show
    @app = App.find(params[:id])

    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @app }
    end
  end
end
