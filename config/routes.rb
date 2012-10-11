ReduApps::Application.routes.draw do
  root :to => 'apps#index'
  resources :apps, :only => [:index, :show] do
    resources :comments
  end
end
