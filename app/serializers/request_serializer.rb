class RequestSerializer < ActiveModel::Serializer
  attributes :id, :amount, :rent_from_date,
    :rent_to_date, :insurance, :renter, :rentee

  has_one :rentee
  has_one :renter
  has_one :product, serializer: RequestProductSerializer

  def insurance
    Request::INSURANCE[object.insurance]
  end
end
