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
class Product < ActiveRecord::Base
  validates :title, presence: true
  validates :price_per_day, presence: true, numericality: { greater_than: 0 }
  acts_as_mappable
  acts_as_taggable

  belongs_to :user

  has_many :assets, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :assets, allow_destroy: true

  def take_assets(params)
    assets = Asset.where(attachable_id: nil, unique_token: params)

    assets.each do |asset|
      asset.attachable = self
      asset.save
    end
  end

  def main_image
    asset_path = ActionController::Base.helpers.asset_path
    return  asset_path 'small-img.jpg' unless assets.any?
    assets.first.image.url(:thumb)
  end

  def total_days
    return 0 unless end_at && available_at
    end_at.day - available_at.day
  end

  def total_price
    return 0 unless total_days && price_per_day
    total_days * price_per_day
  end
end
