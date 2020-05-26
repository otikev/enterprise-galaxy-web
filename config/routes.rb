Rails.application.routes.draw do
  root 'site#home'

  resources :enterprises
  match '/countdown', to: 'site#countdown', via: 'get'
  resources :account_activations, only: [:edit]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
