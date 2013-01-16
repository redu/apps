ReduApps::Application.routes.draw do
  root to: 'apps#index'

  resources :apps, only: [:index, :show] do
    match '/checkout'  => 'checkout#update', via: :post
    match '/checkout' => 'checkout#new', via: :get
    member do
      post 'rate'
    end
    resources :comments, only: [:create, :destroy] do
      resources :answers, only: [:index]
    end
  end

  resources :users, only: [] do
    resources :favorites, only: [:index, :create, :destroy]
  end

  resources :user_sessions, only: [:create]
  delete 'logout' => "user_sessions#destroy", as: :logout

  ActionDispatch::Routing::Translator.translate_from_file('config/locales/routes.yml')
end
