Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'callbacks',
    registrations: 'users/registrations',
    sessions: 'users/sessions' } do
  end
  match 'auth/failure', to: redirect('/'), via: [:get]
  match 'search', to: 'listings#search', as: 'search', via: [:get]

  match 'profile', to: 'users#profile', as: 'my_profile', via: [:get]

  resources :messages, only: [:index, :show]
  resources :users do
    collection do
      get :settings
      put :upload_avatar
      delete :delete_avatar
    end
  end
  resources :listings

  root to: 'home_page#index'
end
