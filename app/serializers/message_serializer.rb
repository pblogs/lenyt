class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :sender, :sender_id, :created_at

  def sender
    object.sender.full_name
  end
end
