class Vote < ApplicationRecord
  belongs_to :arc
  belongs_to :user
end
