Rails.application.routes.draw do
  resources :activs do
    resources :tracks
  end
  post 'login', to: 'access_tokens#create'
  delete 'logout', to: 'access_tokens#destroy'
  post 'sign_up', to: 'registrations#create'
  get '/progress/:name', to: 'tracks#progress'
end
