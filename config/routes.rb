Rails.application.routes.draw do
  root 'landing#index'
  resources :results, only: [:index]

  resource :dashboard, only: [:show], controller: :dashboard do
    get '/address', to: 'dashboard#edit'
    post '/address', to: 'dashboard#update'
  end

  get 'login', to: 'sessions#new'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  patch '/results', to: 'results#index'
end
