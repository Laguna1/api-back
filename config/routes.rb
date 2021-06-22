Rails.application.routes.draw do
   
  post 'sign_up', to: 'registrations#create'
end
