class Arc < ApplicationRecord
  include Snippers
  belongs_to :story
  belongs_to :user
  acts_as_votable
  # has_many :votes
  # has_many :voters, through: :votes, source: :user
  
  validates :body, presence: true

  # Arc is automatically voted at 24 hours after creation

  def prettier_created_at
    self.created_at.time.strftime("%I:%M%p")
  end

  def current_time_left_to_vote
  end

  def times_up?
    if self.created_at.time.advance(hours: +24) == Time.now
      true
    else
      false
    end
  end



end
