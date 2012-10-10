ReduApps::Application.routes.draw do
  root :to => 'apps#index'
  match "/users/:user_id/favorites" => "users#favorites"
  resources :apps do
    resources :comments
  end
end
