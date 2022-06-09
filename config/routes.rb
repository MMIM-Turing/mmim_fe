Rails.application.routes.draw do
  root 'landing#index'
  resources :results, only: [:index]

  resource :dashboard, only: [:show], controller: :dashboard do
    get '/address', to: 'dashboard#edit'
    patch '/address', to: 'dashboard#update'
  end

  namespace :dashboard do
    resources :results, only: [:index]
    resources :user_results, only: [:index]
  end

  post 'dashboard/meeting', to: 'dashboard#new_meeting'
  post 'dashboard/accept', to: 'dashboard#accept_meeting'
  get 'login', to: 'sessions#new'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  patch '/results', to: 'results#index'
  patch '/dashboard/results', to: 'dashboard/results#index'
  patch '/dashboard/user_results', to: 'dashboard/user_results#index'
end
