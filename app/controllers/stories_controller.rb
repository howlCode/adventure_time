class StoriesController < ApplicationController
  before_action :set_story, except: [:index]

  def index
    @stories = Story.all
  end

  def show
  end

  private 

    def set_story
      @story = Story.find(params[:id])
    end

    def story_params
      params.require(:story).permit(:title, :body)
    end
end
