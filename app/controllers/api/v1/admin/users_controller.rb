module Api
  module V1
    class Admin::UsersController < ApplicationController
      before_action :authorize_access_request!
      ROLES = %w[admin].freeze


      def index
        @users = User.all
    
        render json: @users.as_json(only: [:id, :email, :role])
      end
    
      def token_claims
        {
          aud: ROLES,
          verify_aud: true
        }
      end
    end
  end
end