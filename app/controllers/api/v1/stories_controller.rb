module Api
  module V1
    class StoriesController < ApplicationController
      before_action :authenticate_user, except: [:index, :show]
      before_action :set_story, except: [:index, :create]

      def index
        @stories = Story.all
        render json: @stories
      end

      def show
        render json: @story
      end

      def create
        @story = current_user.stories.build(story_params)

        if @story.save
          render status: 200,
                 json: { message: "Story successfully created" }.to_json
        else
          render status: 422
        end
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