class Story < ApplicationRecord
  belongs_to :user
  has_many :arcs
  validates_presence_of :title, :body

  def display_username
    self.user.email
  end
end
