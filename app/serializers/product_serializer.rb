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
  attributes :id, :title, :voted, :details, :request_sent,
        :images, :total_value, :price_per_day, :map, :user

  def images
    object.assets.map { |a| { url: a.image.url } }
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
