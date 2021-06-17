Rails.application.routes.draw do
   
  post 'sign_up', to: 'registrations#create'
  resources :activities do
      resources :trackings
    end
  end
