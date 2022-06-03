Rails.application.routes.draw do

  root 'landing#index'
  resources :results, only: [:index]

  resource :dashboard, only: [:index], controller: :dashboard 

  get 'login', to: 'sessions#new'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

end
