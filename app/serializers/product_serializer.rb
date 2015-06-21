class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :voted, :details, :request_sent,
        :images, :total_value, :price_per_day, :map, :user,
        :tags, :address, :category

  def images
    object.assets.map { |a| { id: a.id, url: a.image.url } }
  end

  def voted
    serialization_options[:voted]
  end

  def map
    {
      lat: object.latitude,
      long: object.longitude
    }
  end

  def request_sent
    serialization_options[:request_sent]
  end

  def user
    owner = serialization_options[:owner]
    {
      id: owner.id,
      name: owner.username,
      avatar: owner.profile_picture,
      rating:
      {
        avg: (owner.trust_average ? owner.trust_average.avg : 0),
        count: (object.user.trust_average ?  object.user.trust_average.qty : 0)
      }
    }
  end
end
