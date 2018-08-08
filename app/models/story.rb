class Story < ApplicationRecord
  belongs_to :user
  has_many :arcs
  validates_presence_of :title, :body

  def display_username
    self.user.email
  end

  def snipped_body
    self.body.truncate(200, omission: '... (click to read full story)')
  end

  def snipped_title
    self.title.truncate(50, omission: '... ')
  end
end
