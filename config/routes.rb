Rails.application.routes.draw do
   
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users,  only: %i[create show index] do
    resources :activities do
      resources :trackings
    end
  end
end
