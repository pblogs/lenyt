# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  username               :string(255)
#  address                :string(255)
#  city                   :string(255)
#  state                  :string(255)
#  country                :string(255)
#  postal_code            :string(255)
#  phone_number           :string(255)
#  email                  :string(255)      default(""), not null
#  password_salt          :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  provider               :string(255)
#  uid                    :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  image_url              :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#

class User < ActiveRecord::Base
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable,
        :validatable,
        :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  validates :email, :username, presence: true
  validates :username, uniqueness: true

  has_attached_file :avatar, styles: { medium: "200x200>", thumb: "100x100>" }
  validates_attachment_content_type :avatar, content_type: /^image\/(png|gif|jpeg|jpg)/

  def self.from_omniauth(auth)
    user_hash = {
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      username: auth.info.name,
      image_url: auth.info.image,
      address: auth.info.address,
      email: auth.info.email,
      provider: auth.provider,
      uid: auth.uid,
      password: Devise.friendly_token[0, 20]
    }
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    user.update_attributes(user_hash)
    user
  end

  def profile_picture
    avatar.present? ? avatar : image_url
  end

  def full_name
    username.present? ? username : email
  end
end
