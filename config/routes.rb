Rails.application.routes.draw do
  get '/', to: redirect('/api/v1/stories')

  namespace :api do
    namespace :v1 do
      get '/', controller: :stories, action: :index

      post 'refresh', controller: :refresh, action: :create
      post 'signin', controller: :signin, action: :create
      post 'signup', controller: :signup, action: :create
      delete 'signin', controller: :signin, action: :destroy
      get 'me', controller: :users, action: :me
      
      resources :stories do
        resources :arcs do
          member do
            put "vote_up", to: "arcs#upvote"
            put "vote_down", to: "arcs#downvote"
          end
        end
      end

      get 'all_unvoted_arcs', controller: :arcs, action: :all_unvoted_arcs
      get 'all_voted_arcs', controller: :arcs, action: :all_voted_arcs

      resources :password_resets, only: [:create] do
        collection do
          get ':token', action: :edit, as: :edit
          patch ':token', action: :update
        end
      end

    end
  end
  
end
