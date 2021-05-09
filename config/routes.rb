Rails.application.routes.draw do
   
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logged_in', to: 'sessions#is_logged_in?'
  resources :users,  only: %i[create show index] do
    resources :activities
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
