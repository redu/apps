ReduApps::Application.routes.draw do
  root :to => 'apps#index'
  resources :apps do
      member do
         get 'preview'
      end
      resources :comments
  end

  resources :users do
     resources :favorites
  end

end
