class Arc < ApplicationRecord
  include Snippers
  belongs_to :story
  belongs_to :user
  acts_as_votable
  
  validates :body, presence: true
end
