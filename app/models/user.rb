class User < ApplicationRecord
  has_secure_password
  validates :email, :nickname, presence: true
  validates_uniqueness_of :email, :nickname
  has_many :stories
  has_many :arcs
  has_many :votes
  
  enum role: %i[user manager admin].freeze

  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            presence: true,
            uniqueness: { case_sensitive: false }
end
