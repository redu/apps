require "spec_helper"

describe ApplicationController do

  describe "routing" do

    it "routes root to apps#index" do
      { get: "/", locale: 'pt-BR' }.should 
        route_to("apps#index", locale: 'pt-BR')
    end
  end

end

describe AppsController do

  describe "routing" do

    it "routes to #index" do
      { get: "/apps", locale: 'pt-BR' }.should 
        route_to("apps#index", locale: 'pt-BR')
    end

    it "routes to #show" do
      { get: "/apps/1", locale: 'pt-BR' }.should 
        route_to("apps#show", id: '1', locale: 'pt-BR')
    end

    it "routes to #preview" do
      { get: "/apps/1/preview", locale: 'pt-BR' }.should 
        route_to("apps#preview", id: '1', locale: 'pt-BR')
    end

    it "routes to #rate" do
      { post: "/apps/1/rate", rating: 5, locale: 'pt-BR' }.should 
        route_to("apps#rate", id: '1', locale: 'pt-BR')
    end
  end
end

describe CommentsController do

  describe "routing" do

    it "routes to #create" do
      { post: "/apps/1/comentarios", locale: 'pt-BR' }.should 
        route_to("comments#create", id: '1', locale: 'pt-BR')
    end

    it "routes to #destroy" do
      { delete: "/apps/1/comentarios/1", locale: 'pt-BR' }.should 
        route_to("apps#show", app_id: '1', id: '1', locale: 'pt-BR')
    end
  end
end

describe FavoritesController do

  describe "routing" do

    it "routes to #index" do
      { get: "/usuarios/1/favoritos", locale: 'pt-BR' }.should 
        route_to("favorites#index", id: '1', locale: 'pt-BR')
    end

    it "routes to #create" do
      { post: "/usuarios/1/favoritos", locale: 'pt-BR' }.should 
        route_to("apps#show", id: '1', locale: 'pt-BR')
    end
  end
end
