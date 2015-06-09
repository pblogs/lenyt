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
class Request < ActiveRecord::Base
  belongs_to :renter, class_name: 'User', foreign_key: :renter_id # owner
  belongs_to :rentee, class_name: 'User', foreign_key: :rentee_id # one who rents it
end
