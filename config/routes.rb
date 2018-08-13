Rails.application.routes.draw do
  devise_for :users
  root to: "stories#index"

  resources :stories do
    resources :arcs do
      resources :votes, only: [:create]
    end
  end
  
end
