class StorySerializer < ActiveModel::Serializer
  belongs_to :user, serializer: UserSerializer
  has_many :arcs, serializer: ArcSerializer
  
  attributes :id, :title, :body, :user, :arcs
end