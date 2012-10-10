ReduApps::Application.routes.draw do
  root :to => 'apps#index'
  resources :apps do
    resources :comments
  end
end
