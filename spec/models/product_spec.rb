# == Schema Information
#
# Table name: products
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  price_per_day :integer          default(0)
#  total_value   :integer          default(0)
#  details       :text
#  is_available  :boolean          default(FALSE)
#  available_at  :date
#  end_at        :date
#  meet_location :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  user_id       :integer
#  category_id   :integer
#

require 'rails_helper'

RSpec.describe Product, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
