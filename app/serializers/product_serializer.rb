# == Schema Information
#
# Table name: products
#
#  id                          :integer          not null, primary key
#  title                       :string
#  price_per_day               :integer          default(0)
#  total_value                 :integer          default(0)
#  details                     :text
#  is_available                :boolean          default(FALSE)
#  available_at                :date
#  end_at                      :date
#  created_at                  :datetime
#  updated_at                  :datetime
#  user_id                     :integer
#  category_id                 :integer
#  address                     :string
#  latitude                    :float
#  longitude                   :float
#  gmaps                       :boolean
#  postal_code                 :string
#  country                     :string
#  locality                    :string
#  administrative_area_level_2 :string
#  administrative_area_level_1 :string
#  location_type               :string
#

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
