class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :participant

  has_one :request
  has_many :messages

  def participant
    user = object.participants.delete(serialization_options[:current_user])
    participant = {
      avatar: user.profile_picture,
      username: user.username
    }
  end
end
