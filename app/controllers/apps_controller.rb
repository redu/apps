# encoding: utf-8

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
    @app.update_attribute(:views, @app.views + 1)
    @user = current_user
    if @user
      @evaluated = @app.has_evaluation?(:rating, @user)
      @user_rating = @app.reputation_for(:rating, nil, @user) if @evaluated
    end
    respond_to do |format|
      format.html  # show.html.erb
      format.json  { render :json => @app }
    end
  end

  def preview
    @app = App.find(params[:id])
  end

  def rate
    rating = Integer(params[:rating])
    @app = App.find(params[:id])
    @app.add_or_update_evaluation(:rating, rating, current_user)
    redirect_to :back, notice: "Você classificou o recurso com #{rating}."

  def search
    @search = App.search do
      fulltext params[:search] do
        boost_fields :name => 2.0 # Prioridade para itens com o termo no nome
        query_phrase_slop 3 # 3 palavras podem aparecer entre os termos da busca
        phrase_fields :description => 2.0 # Prioriza se aparecer a frase na desc
        phrase_fields :synopsis => 2.0 # Prioriza se aparecer a frase na sinopse
      end
    end
    @apps = @search.results

    render :index
  end
end
