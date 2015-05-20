Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'callbacks',  registrations: 'users/registrations',  sessions: 'users/sessions' } do
    #match 'settings', to: 'users/registrations#settings', as: :settings, via: [:get]
  end
  match 'auth/failure', to: redirect('/'), via: [:get]
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
