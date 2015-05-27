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

class Product < ActiveRecord::Base
  validates :title, presence: true
  validates :price_per_day, presence: true, numericality: {greater_than: 0}

  acts_as_taggable

  belongs_to :user

  has_many :assets, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :assets, allow_destroy: true

  def take_assets(params)
    assets = Asset.where(attachable_id: nil, unit_token: params)

    assets.each do |asset|
      asset.attachable = self
      asset.save
    end
  end
end
