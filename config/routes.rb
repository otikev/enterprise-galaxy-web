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
  match '/unlock', to: 'auth#unlock', via: :get
  #End Auth controller

  #Enterprises controller
  match '/enterprise_profile', to: 'enterprises#show', via: 'get'
  match '/enterprise_dashboard', to: 'enterprises#dashboard', via: 'get'
  match '/enterprise_edit_profile', to: 'enterprises#edit_profile', via: [:get, :post]
  #End Enterprises controller

  #Advisers controller
  match '/adviser_profile', to: 'advisers#show', via: 'get'
  match '/adviser_dashboard', to: 'advisers#dashboard', via: 'get'
  match '/adviser_edit_profile', to: 'advisers#edit_profile', via: [:get, :post]
  #End Advisers controller

  #Content ContentController
  match '/all_content', to: 'content#all', via: 'get'
  #End Content ContentController

  #Admins controller
  match '/admins/dashboard', to: 'admins#dashboard', via: 'get'
  match '/admins/enterprises', to: 'admins#enterprises', via: 'get'
  match '/admins/advisers', to: 'admins#advisers', via: 'get'
  #End Admins controller

  #Other
  match '/countdown', to: 'site#countdown', via: 'get'
  match '/theme', to: 'enterprises#theme', via: 'get'
  match '/dashboard', to: 'enterprises#dashboard', via: 'get'
  #End Other
end
