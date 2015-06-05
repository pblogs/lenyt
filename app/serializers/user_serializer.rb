class UserSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :username, :address, :email, :avatar

  def avatar
    object.profile_picture
  end
end
