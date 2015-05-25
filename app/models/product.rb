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

class Product < ActiveRecord::Base
  validates :title, presence: true
  validates :price_per_day, presence: true, numericality: {greater_than: 0}

  acts_as_taggable

  belongs_to :user

  has_many :assets, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :assets
end
