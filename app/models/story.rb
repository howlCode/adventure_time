class Story < ApplicationRecord
  include Snippers
  belongs_to :user
  has_many :arcs, dependent: :destroy
  validates :title, :body, presence: true
  validates :title , uniqueness: true

  def prettier_created
    "Written by #{self.user.nickname} #{self.created_at.strftime('on %m/%d/%Y at %I:%M%p')}"
  end
end
