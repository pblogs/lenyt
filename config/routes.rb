Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'callbacks',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    invitations: 'users/invitations'
  } do
    # match 'settings', to: 'users/registrations#settings'
  end
  match 'auth/failure', to: redirect('/'), via: [:get]
  match 'search', to: 'listings#search', as: 'search', via: [:get]

  match 'profile', to: 'users#profile', as: 'my_profile', via: [:get]

  resources :messages, only: [:index, :show, :create]
  resources :conversations, only: [:index, :show]
  resources :users do
    collection do
      get :settings
      put :upload_avatar
      delete :delete_avatar
    end
  end
  resources :pictures
  resources :listings

  namespace :api, defaults: { format: :json } do
    get '/users/current'
    post '/rate' => 'rater#create', :as => 'rate'
    resources :users do
      collection do
        put 'newsletter_notifcations'
        put 'messages_notifcations'
      end
      member do
        get 'products'
      end
    end
    resources :products, only: [:index, :show]
    resources :requests
    resources :assets do
      member do
        delete 'delete_new_asset'
      end
    end
    resources :tags, only: :index
    resources :messages, only: :create
    resources :conversations, only: [:index, :show]
  end

  authenticated do
    root :to => 'listings#search', as: :authenticated
  end

  root to: 'home_page#index'
end
