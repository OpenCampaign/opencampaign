OpenCampaign::Application.routes.draw do

  get "/auth/#{Authentication.const_get(ENV['AUTHENTICATION_MODULE'].classify)::PROVIDER}", as: 'login'
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  get '/auth/failure', to: 'sessions#failure'
  get '/logout', to: 'sessions#destroy'
  get '/login', as: 'user_login', to: 'sessions#new'
  get '/register', to: 'basic_auths#new'
  match '/users/verify-email/:basic_auth_id/:token', to: 'basic_auths#verify', as: 'verify_email', via: [:get]
  match '/users/password-reset/:basic_auth_id/:token', to: 'basic_auths#reset', as: 'password_reset', via: [:get, :post]
  match '/users/forgot-password', to: 'basic_auths#forgot', as: 'forgot_password', via: [:get, :post]

  resources :users, only: [:show, :edit, :update]

  namespace :admin do
    resources :roles, only: [:index, :create]
    resources :issues
  end

  match '/admin', to: 'admin#index', as: 'admin', via: [:get, :post]

end
