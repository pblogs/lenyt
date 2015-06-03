class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :request, :messages, :created_at

   #, :body, :sender, :sender_id, :created_at, :request

  # def sender
  #   object.sender.full_name
  # end

  has_many :messages

  def request
    title = object.id.even? ? 'Leica M6' : 'Nikon D10'
    days = object.id.even? ? 15 : 25
    total = days * 5
    sent_on = object.id.even? ? 1.week.from_now : 4.days.from_now

    {
      article: {
        title: title
      },
      days: days,
      total: total,
      sent_on: sent_on,
      image_url: image
    }
  end

  def image
    nikon_url = 'http://tapscape.com/wp-content/uploads/2013/01/Nikon-D5100.jpg'
    leica_url = 'http://upload.wikimedia.org/wikipedia/commons/c/ce/Leica_m6.jpg'

    _helpers = ActionController::Base.helpers
    _helpers.image_url (object.id.even? ? leica_url : nikon_url)
  end
end
