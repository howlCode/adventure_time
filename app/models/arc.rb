class Arc < ApplicationRecord
  include Snippers
  belongs_to :story
  belongs_to :user
  validates :body, presence: true
end
