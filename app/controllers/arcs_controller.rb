class ArcsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_story, only: [:new, :create]
  before_action :set_arc, only: [:destroy]

  def new
    @arc = current_user.arcs.build(story_id: params[:story_id])
  end

  def create
    @arc = current_user.arcs.build(arc_params)
    if @arc.save
      redirect_to @story
    else
      render 'new'
    end
  end

  def destroy
    @arc.destroy

    redirect_to stories_path
  end

  private
    def set_arc
      @arc = Story.arcs.find(params[:id])
    end

    def load_story
      @story = Story.find(params[:story_id])
    end

    def arc_params
      params.require(:arc).permit(:body, :story_id)
    end
end
