Rails.application.routes.draw do
   
    resources :activities do
      resources :tracks
    end

end
