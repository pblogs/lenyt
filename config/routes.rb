Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }
  match 'auth/failure', to: redirect('/'), via: [:get]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  match 'search', to: 'listings#search', as: 'search', via: [:get]

  match 'profile', to: 'users#profile', as: 'my_profile', via: [:get]
  match 'messages', to: 'users#messages', as: 'my_messages', via: [:get]

  resources :users do
    collection do
      get :settings
    end
  end
  resources :listings

  root to: 'home_page#index'
end
