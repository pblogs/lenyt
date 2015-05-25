class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :sender_name, :sender_id, :created_at

  def sender_name
    object.sender.full_name
  end
end
