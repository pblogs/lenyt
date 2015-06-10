class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :created_at

  has_one :request
  has_many :messages
end
