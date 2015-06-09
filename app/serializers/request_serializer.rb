class RequestSerializer < ActiveModel::Serializer
  attributes :id, :amount, :rent_from_date,
    :rent_to_date, :insurance, :renter, :rentee

  def  renter
    user = object.renter
    {
        id: user.id,
        email: user.email,
        username: user.username
    }
  end

  def rentee
    user = object.rentee
    {
        id: user.id,
        email: user.email,
        username: user.username
    }
  end

  def insurance
    Request::INSURANCE[object.insurance]
  end

end
