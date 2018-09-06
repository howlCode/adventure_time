module Api
  module V1
    class ArcsController < ApplicationController
      # before_action :authenticate_user!
      before_action :load_story
      before_action :set_arc, except: [:create, :index]

      def index
        @arcs = @story.arcs.all
        render json: @arcs
      end

      def show
        render json: @arc
      end

      def create
        @arc = current_user.arcs.build(arc_params)
        if @arc.save
          render json: "Story-arc successfully saved", status: 200
        else
          render json: status: 422
        end
      end

      def destroy
        @arc.destroy
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