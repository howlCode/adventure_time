class Arc < ApplicationRecord
  include Snippers
  belongs_to :story
  belongs_to :user
  acts_as_votable

  validates :body, presence: true

  def expired
    expire_time = self.created_at.advance(days: 1)
    if Time.now >= expire_time 
      true
    else
      false
    end
  end

  def time_left
    expire_time = self.created_at.advance(days: 1)
    time_remaining = expire_time - Time.now
    expire_time.strftime("Voting closes: %m/%d at %I:%M%p")
  end

end
