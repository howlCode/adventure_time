module Api
  module V1
    class ArcsController < ApplicationController
      before_action :authorize_access_request!, except: [:all_arcs, :index, :show]
      before_action :load_story, except: [:all_arcs]
      before_action :set_arc, except: [:all_arcs, :create, :index]

      def all_arcs
        @arcs = Arc.all
        render json: @arcs.as_json(include: [:story, :user, :votes_for, :get_upvotes, :get_downvotes])
      end

      def index
        @arcs = @story.arcs.all
        render json: @arcs.as_json(include: [:user, :votes_for, :get_upvotes, :get_downvotes])
      end

      def show
        render json: @arc.as_json(include: [:story, :user, :votes_for, :get_upvotes, :get_downvotes])
      end

      def create
        @arc = current_user.arcs.build(arc_params)

        if @arc.save
          render json: @arc, status: :created, location: api_v1_story_arc_path(@story, @arc)
        else
          render json: @arc.errors, status: :unprocessable_entity
        end
      end

      def update
        if @arc.update(arc_params)
          render json: @arc
        else
          render json: @arc.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @arc.destroy
      end

      def upvote
        @arc = Arc.find(params[:id])
        @arc.upvote_by current_user
        render json: "Vote captured!"
      end

      def downvote
        @arc = Arc.find(params[:id])
        @arc.downvote_by current_user
        render json: "Vote captured!"
      end 

      private

        def set_arc
          @arc = @story.arcs.find(params[:id])
        end

        def load_story
          @story = Story.find(params[:story_id])
        end

        def arc_params
          params.require(:arc).permit(:body, :story_id)
        end
    end
  end
end