Rails.application.routes.draw do
  root 'site#home'

  match '/enterprises/registration', to: 'auth#enterprise', via: [:get, :post]
  match '/advisers/registration', to: 'auth#adviser', via: [:get, :post]
  match '/enterprises/registration/success', to: 'auth#enterprise_signup_success', via: :get
  match '/advisers/registration/success', to: 'auth#adviser_signup_success', via: :get
  match '/signin', to: 'auth#signin', via: [:get, :post]
  match '/signup', to: 'auth#signup', via: :get

  match '/countdown', to: 'site#countdown', via: 'get'

  match '/theme', to: 'enterprises#theme', via: 'get'
  resources :account_activations, only: [:edit]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end