module Api
  module V1
    class Admin::Users::StoriesController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_user
      ROLES = %w[admin].freeze

      def index
        render json: @user.stories
      end

      def token_claims
        {
          aud: ROLES,
          verify_aud: true
        }
      end

      private

      def set_user
        @user = User.find(params[:user_id])
      end
    end
  end
end