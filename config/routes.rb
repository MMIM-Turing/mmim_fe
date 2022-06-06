Rails.application.routes.draw do
  root 'landing#index'
  resources :results, only: [:index]

  resource :dashboard, only: [:show], controller: :dashboard do
    get '/address/new', to: 'dashboard#edit'
  end

  namespace :dashboard do
    resources :results, only: [:index]
  end

  get 'login', to: 'sessions#new'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  patch '/results', to: 'results#index'
end
