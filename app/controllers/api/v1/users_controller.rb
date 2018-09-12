module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_access_request!

      def me
        render json: current_user.as_json(only: [:id, :nickname, :email])
      end
    end

  end
end