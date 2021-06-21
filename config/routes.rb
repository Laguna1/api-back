Rails.application.routes.draw do
   
    resources :activities do
      resources :trackings
    end

end
