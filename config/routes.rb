Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :stories do
        resources :arcs do
          resources :votes, only: [:create]
        end
      end
    end
  end
  
end
