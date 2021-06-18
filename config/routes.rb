Rails.application.routes.draw do
  resources :activities do
    resources :trackings
  end
  post 'login', to: 'access_tokens#create'
  delete 'logout', to: 'access_tokens#destroy'
  post 'sign_up', to: 'registrations#create'
  
  end
