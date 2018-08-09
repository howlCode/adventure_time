class Story < ApplicationRecord
  include Snippers
  belongs_to :user
  has_many :arcs
  validates :title, :body, presence: true
end
