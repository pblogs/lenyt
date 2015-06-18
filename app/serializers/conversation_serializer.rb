class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :options, :participant

  has_one :request
  has_many :messages

  def options
    return {request_buttons: false} unless object.request
    {
      request_buttons: object.request.renter == serialization_options[:current_user]
    }
  end

  def participant
    require 'pry'
    binding.pry
    user = object.participants.delete(serialization_options[:current_user])
    participant = {
      avatar: user.profile_picture,
      username: user.username
    }
  end
end
