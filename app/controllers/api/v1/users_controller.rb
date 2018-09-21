module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_access_request!, except: [:profile]

      def me
        render json: the_current_user.as_json(only: [:id, :nickname, :email]), status: 200
      end

      def profile
        @user = User.find(params[:id])
        @stories = @user.stories.all
        @arcs = @user.arcs.all
        render json: { user: @user, stories: @stories, arcs: @arcs }, status: 200
      end

    end

  end
end