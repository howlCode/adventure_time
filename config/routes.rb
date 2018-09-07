Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      post 'signup' => 'signup#create'
      post 'signin' => 'signin#create'
      post 'refresh' => 'refresh#create'
      resources :stories do
        resources :arcs do
          resources :votes, only: [:create]
        end
      end
    end
  end
  
end
