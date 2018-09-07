module Api
  module V1
    class ArcsController < ApplicationController
      before_action :authorize_access_request!, except: [:index, :all]
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
          render render json: @arc, status: :created, location: api_v1_arc_path(@arc)
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