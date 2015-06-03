class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :image, :price_per_day, :map, :user

  def image
    object.main_image
  end

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
