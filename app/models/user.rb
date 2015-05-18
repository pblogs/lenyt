class User < ActiveRecord::Base
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

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

  def avatar
    image_url
  end

  def full_name
    username.present? ? username : email
  end
end
