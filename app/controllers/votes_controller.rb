class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @story = Story.find(:story_id)
    @vote = Vote.new(vote_params)
    if @vote.save
      redirect_to story_arcs_path(@story)
    end
  end

  private
    def vote_params
      params.require(:vote).permit(:arc_id, :user_id)
    end

end