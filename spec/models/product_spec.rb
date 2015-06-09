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

require 'rails_helper'

RSpec.describe Product, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
