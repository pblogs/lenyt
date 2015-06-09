# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  last_name              :string
#  username               :string
#  address                :string
#  city                   :string
#  state                  :string
#  country                :string
#  postal_code            :string
#  phone_number           :string
#  email                  :string           default(""), not null
#  password_salt          :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  provider               :string
#  uid                    :string
#  created_at             :datetime
#  updated_at             :datetime
#  image_url              :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  newsletter             :boolean          default(TRUE)
#  messages               :boolean          default(TRUE)
#

class UserSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :username, :address, :email, :avatar

  def avatar
    object.profile_picture
  end
end
