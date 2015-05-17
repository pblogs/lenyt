class Product < ActiveRecord::Base
  validates :title, presence: true
  validates :price_per_day, presence: true, numericality: {greater_than: 0}

  acts_as_taggable

  has_many :assets, as: :attachable
  accepts_nested_attributes_for :assets

end
