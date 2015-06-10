class RequestProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :image

  def image
    object.main_image
  end
end
