class Story < ApplicationRecord
  include Snippers
  belongs_to :user
  has_many :arcs, dependent: :destroy
  validates :title, :body, presence: true
  validates :title , uniqueness: true

end
