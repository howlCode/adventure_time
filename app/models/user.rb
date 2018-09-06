class User < ApplicationRecord
  has_secure_password
  validates :email, :nickname, presence: true
  validates_uniqueness_of :email, :nickname
  has_many :stories
  has_many :arcs
  has_many :votes

  def to_token_payload
    {
        sub: id,
        nickname: nickname
    }
  end
end
