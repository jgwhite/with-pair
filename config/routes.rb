Pair::Application.routes.draw do
  root to: 'home#show'

  get 'ping' => 'pings#show'

  resources :sessions, only: [] do
    resources :bookings, only: [:new, :create, :show]
  end

  namespace :admin do
    root to: 'dashboard#show'
    patch 'person' => 'dashboard#update', as: :person
    get 'login' => 'auth#new', as: :login
    get 'logout' => 'auth#destroy', as: :logout
    resources :sessions, only: [:create] do
      get 'destroy' => 'sessions#destroy', as: :destroy
    end
    get 'history' => 'history#show', as: :history
  end

  get '/auth/google_oauth2/callback' => 'callbacks#handle'
end
