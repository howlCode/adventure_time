class Arc < ApplicationRecord
  include Snippers
  belongs_to :story
  belongs_to :user
  acts_as_votable

  validates :body, presence: true

  def expired
    expire_time = self.created_at.advance(days: 1)
    if self.created_at >= expire_time 
      true
    else
      false
    end
  end

end
