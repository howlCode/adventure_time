class Arc < ApplicationRecord
  include Snippers
  acts_as_votable
  belongs_to :story
  belongs_to :user
  validates :body, presence: true
end
