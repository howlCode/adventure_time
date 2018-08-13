class User < ApplicationRecord
  has_many :stories
  has_many :arcs

  has_many :votes
  has_many :up_votes, through: :votes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

end
