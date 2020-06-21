Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'site#home'

  #Auth controller
  match '/enterprises/registration', to: 'auth#enterprise', via: [:get, :post]
  match '/advisers/registration', to: 'auth#adviser', via: [:get, :post]
  match '/registration/success', to: 'auth#signup_success', via: :get
  match '/signin', to: 'auth#signin', via: [:get, :post]
  match '/signup', to: 'auth#signup', via: :get
  match '/forgot_password', to: 'auth#forgot_password', via: [:get, :post]
  match '/password_reset', to: 'auth#password_reset', via: [:get, :post]
  match '/activate', to: 'auth#activate', via: :get
  match '/multi_factor', to: 'auth#two_factor', via: [:get, :post]
  match '/logout', to: 'auth#signout', via: :get
  #End Auth controller

  #Enterprises controller
  match '/enterprise_dashboard', to: 'enterprises#show', via: 'get'
  #End Enterprises controller

  #Advisers controller
  match '/adviser_dashboard', to: 'advisers#show', via: 'get'
  match '/adviser_edit_profile', to: 'advisers#profile', via: [:get, :post]
  #End Advisers controller

  #Other
  match '/countdown', to: 'site#countdown', via: 'get'
  match '/theme', to: 'enterprises#theme', via: 'get'
  match '/dashboard', to: 'enterprises#dashboard', via: 'get'
  #End Other
end