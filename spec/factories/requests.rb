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

FactoryGirl.define do
  factory :request do
    renter_id 1
rentee_id 1
amount "MyString"
rent_from_date "2015-06-09"
rent_to_date "2015-06-09"
  end

end
