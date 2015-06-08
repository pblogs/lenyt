class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :images, :total_value, :price_per_day, :map, :user, :details, :voted

  def images
    object.assets.map{|a| {url: a.image.url}}
  end

  def voted
    true
  end

  def map
    {
      lat: object.latitude,
      long: object.longitude
    }
  end

  def user
    {
      id: object.user.id,
      name: object.user.username,
      avatar: object.user.profile_picture,
      rating:
      {
        avg: (object.user.trust_average ? object.user.trust_average.avg : 0), # rand(1.0..5.0)
        count: (object.user.trust_average ?  object.user.trust_average.qty : 0)
      }
    }
  end
end
