# == Schema Information
#
# Table name: requests
#
#  id             :integer          not null, primary key
#  renter_id      :integer
#  rentee_id      :integer
#  amount         :string           default("0")
#  rent_from_date :date
#  rent_to_date   :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Request, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
