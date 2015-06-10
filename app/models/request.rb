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
#  insurance      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Request < ActiveRecord::Base
  belongs_to :renter, class_name: 'User', foreign_key: :renter_id # owner
  belongs_to :rentee, class_name: 'User', foreign_key: :rentee_id # one who rents it
  belongs_to :product

  after_create :init_conversation

  validates :rentee_id, :product_id, :renter_id, :insurance, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :rent_from_date, date: true

  validates :rent_to_date, date: { after: :rent_from_date }

  INSURANCE = {
    1 => 'Damage Waver',
    2 => 'Full Deposit'
  }

  def init_conversation
    subject = "request for #{product.title}"
    rentee.send_message(
      renter, 'Hi, I am interested to rent this!', subject, id
    )
  end
end
