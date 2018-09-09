module Api
  module V1
    class StoriesController < ApplicationController
      before_action :authorize_access_request!, except: [:index, :show]
      before_action :set_story, except: [:index, :create]

      def index
        @stories = Story.all
        render json: @stories.as_json(include: :arcs)
      end

      def show
        render json: @story.as_json(include: :arcs)
      end

      def create
        @story = current_user.stories.build(story_params)

        if @story.save
          render json: @story, status: :created, location: api_v1_story_path(@story)
        else
          render json: @story.errors, status: :unprocessable_entity
        end
      end

      def update
        if @story.update(story_params)
          render json: @story
        else
          render json: @story.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @story.destroy
      end

      private 

        def set_story
          @story = Story.find(params[:id])
        end

        def story_params
          params.require(:story).permit(:title, :body)
        end
    end
  end
end