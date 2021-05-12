Rails.application.routes.draw do
   
  root 'static_pages#home'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logged_in', to: 'sessions#method_logged_in?'
  resources :users,  only: %i[create show index] do
    resources :activities do
      resources :trackings
    end
  end
end
