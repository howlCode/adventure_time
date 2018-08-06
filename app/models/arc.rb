class Arc < ApplicationRecord
  belongs_to :story, :user
end
