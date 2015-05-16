Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }
  match 'auth/failure', to: redirect('/'), via: [:get]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  resources :users do
    collection do
      get :profile
      get :settings
    end
  end
  root to: 'home_page#index'
end
