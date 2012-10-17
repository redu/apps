ReduApps::Application.routes.draw do
  root :to => 'apps#index'

  resources :apps, :only => [:index, :show] do
    member do
      get 'preview'
    end
    resources :comments, :only => [:create, :destroy]
  end

  resources :users, :only => [] do
    resources :favorites, :only => [:index, :create]
  end

  ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml')
end
