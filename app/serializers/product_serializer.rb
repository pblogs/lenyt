class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :price_per_day, :map, :user

  def map
    {
      lat: object.latitude,
      long: object.longitude
    }
  end

  def user
    object.user.profile_picture
  end
end
