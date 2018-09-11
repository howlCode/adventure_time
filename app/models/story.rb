class Story < ApplicationRecord
  include Snippers
  belongs_to :user
  has_many :arcs, dependent: :destroy
  validates :title, :body, presence: true
  validates_uniqueness_of :title 
end
