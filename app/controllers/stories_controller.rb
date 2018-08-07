class StoriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_story, except: [:index, :new, :create]

  def index
    @stories = Story.all
  end

  def show
  end

  def new
    @story = current_user.stories.build
  end

  def edit
  end

  def create
    @story = current_user.stories.build(story_params)

    if @story.save
      redirect_to @story
    else
      render 'new'
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
