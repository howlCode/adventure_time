module Api
  module V1
    class VotesController < ApplicationController
      include Voting
      # before_action :authenticate_user!

      def create
        @user = current_user
        @arc = Arc.find(params[:arc_id])

        if !has_voted?(@user, @arc)
          @vote = Vote.create(user_id: @user.id, arc_id: @arc.id)
          render json: "Vote has been noted", status: 200
        else
          render json: "User has already voted", status: 422
        end
      end

      private
        def vote_params
          params.require(:vote).permit(:arc_id, :user_id)
        end

    end
  end
end