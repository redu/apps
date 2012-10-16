ReduApps::Application.routes.draw do
  root :to => 'apps#index'

  resources :apps, :only => [:index, :show] do
    member do
      get 'preview'
    end
    resources :comments, :except => :edit do
      resources :comments, :except => :edit
    end
  end

  resources :users do
    resources :favorites
  end
end
