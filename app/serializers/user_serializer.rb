class UserSerializer < ActiveModel::Serializer
  has_many :arcs, serializer: ArcSerializer
  has_many :stories, serializer: StorySerializer
  
  attributes :id, :nickname, :stories, :arcs 
end