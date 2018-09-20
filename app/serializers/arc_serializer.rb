class ArcSerializer < ActiveModel::Serializer
  belongs_to :user, serializer: UserSerializer
  belongs_to :story, serializer: StorySerializer
  
  attributes :id, :story, :body, :votes_for, :get_upvotes, :get_downvotes, :expired, :time_left, :expiry, :inscribed, :winning_time
end