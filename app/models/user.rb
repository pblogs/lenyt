class User < ActiveRecord::Base

  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :encryptable
  devise :omniauthable, omniauth_providers: [:facebook]
end
