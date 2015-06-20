class UserSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :username,
      :address, :email, :avatar, :newsletter_notifcations,
      :messages_notifcations, :rating
  def avatar
    object.profile_picture
  end

  def rating
    {
      avg: (object.trust_average ? object.trust_average.avg : 0),
      count: (object.trust_average ?  object.trust_average.qty : 0)
    }
  end
end
