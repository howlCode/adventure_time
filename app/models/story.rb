class Story < ApplicationRecord
  belongs_to :user
  validates_presence_of :title, :body

  def display_username
    self.user.email
  end
end
