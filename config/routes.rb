Rails.application.routes.draw do
  root 'site#home'

  resources :enterprises
  resources :advisers
  match '/countdown', to: 'site#countdown', via: 'get'
  match '/signup', to: 'enterprises#signup', via: 'get'
  resources :account_activations, only: [:edit]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
