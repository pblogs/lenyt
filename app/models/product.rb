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
  validates :title, :address, :tag_list, presence: true
  validates :price_per_day, presence: true, numericality: { greater_than: 0 }
  acts_as_mappable
  acts_as_taggable

  belongs_to :user
  belongs_to :category

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
    return  ActionController::Base.helpers.asset_path 'small-img.jpg' unless assets.any?
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

  def self.search(params)
    params ||= {}
    min = params[:price_min] ||= '10'
    max = params[:price_max] ||= '500'
    sdate = params[:start_date] ||= 1.day.ago
    edate = params[:end_date] ||=  (sdate.to_date + 1.month).to_date

    products = Product.where('available_at between ? and ? or end_at between ? and ?', sdate, edate, sdate, edate)
    products = products.where(price_per_day: [min..max])

    if params[:tag_id]
      products = products.includes(:taggings).where(taggings: { tag_id: params[:tag_id] })
    end

    if params[:category_id]
      products = products.where(category_id: params[:category_id])
    end

    products
  end
end
