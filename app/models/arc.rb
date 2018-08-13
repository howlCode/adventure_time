class Arc < ApplicationRecord
  include Snippers
  belongs_to :story
  belongs_to :user

  has_many :votes
  has_many :voters, through: :votes
  
  validates :body, presence: true
end
