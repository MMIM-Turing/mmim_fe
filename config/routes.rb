Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing#index'

  resource :dashboard, only: [:index], controller: :dashboard 

  get 'login', to: 'sessions#new'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
end
