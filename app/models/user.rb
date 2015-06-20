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

class User < ActiveRecord::Base
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable,
        :validatable,
        :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  ratyrate_rater
  ratyrate_rateable 'trust'

  validates :email, :username, presence: true
  validates :username, uniqueness: true
  acts_as_messageable

  has_attached_file :avatar, styles: { medium: "200x200>", thumb: "100x100>" }
  validates_attachment_content_type :avatar, content_type: /^image\/(png|gif|jpeg|jpg)/

  has_many :products
  has_many :requests, foreign_key: :renter_id
  has_many :sent_requests, class_name: 'Request', foreign_key: :rentee_id

  def self.from_omniauth(auth)
    username = User.parse_username(auth.info.name, auth.provider)
    user_hash = {
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      username: username,
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

  def self.parse_username(string, provider)
    # (provider == 'google_oauth2') ? string[/\(.*?\)/].gsub('(', '').gsub(')', '') : auth.info.name
    string
  end

  def profile_picture
    return avatar.url(:thumb) if avatar.present?
    return image_url unless image_url.blank?
    ActionController::Base.helpers.asset_path 'default_avatar.png'
  end

  def full_name
    username.present? ? username : email
  end
end
