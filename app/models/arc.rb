class Arc < ApplicationRecord
  include Snippers
  after_create :voting_window
  belongs_to :story
  belongs_to :user
  acts_as_votable

  validates :body, presence: true

  def voting_window
    self.expiry = Date.current.end_of_day.in_time_zone(Time.zone)
    self.save
  end

  def expired
    if Time.now >= self.expiry
      true
    else
      false
    end
  end

  def time_left
    self.expiry.strftime("Voting closes tonight after %I:%M%p")
  end

  def winning_time
    self.expiry.strftime("%m/%d/%y")
  end

end