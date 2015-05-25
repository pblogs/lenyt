# == Schema Information
#
# Table name: products
#
#  id                          :integer          not null, primary key
#  title                       :string(255)
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
#  address                     :string(255)
#  latitude                    :float
#  longitude                   :float
#  gmaps                       :boolean
#  postal_code                 :string(255)
#  country                     :string(255)
#  locality                    :string(255)
#  administrative_area_level_2 :string(255)
#  administrative_area_level_1 :string(255)
#  location_type               :string(255)
#

require 'rails_helper'

RSpec.describe Product, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
