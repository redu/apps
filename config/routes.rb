ReduApps::Application.routes.draw do
  root :to => 'apps#index'

  resources :apps, :only => [:index, :show] do
    member do
      get 'preview'
    end
    resources :comments
  end

  resources :users, :only => [] do
    resources :favorites, :only => [:index, :create, :destroy]
  end
end
