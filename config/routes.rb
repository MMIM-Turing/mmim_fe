Rails.application.routes.draw do
  root 'landing#index'
  resources :results, only: [:index]

<<<<<<< HEAD
  resource :dashboard, only: [:show], controller: :dashboard do
    get '/address/new', to: 'dashboard#edit'
=======
  resource :dashboard, only: [:show], controller: :dashboard do 
    get '/address', to: 'dashboard#edit'
    post '/address', to: 'dashboard#update'
>>>>>>> 46335da7203ae9dd27636792f724d5fb58d0d60d
  end

  namespace :dashboard do
    resources :results, only: [:index]
  end

  get 'login', to: 'sessions#new'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  patch '/results', to: 'results#index'
end
