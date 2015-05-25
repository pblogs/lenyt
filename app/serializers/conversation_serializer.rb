class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :request, :messages, :created_at

   #, :body, :sender, :sender_id, :created_at, :request

  # def sender
  #   object.sender.full_name
  # end

  has_many :messages

  def request
    {
      article: {
        title: 'Leica M6'
      },
      days: 10,
      total: 250
    }
  end
end
