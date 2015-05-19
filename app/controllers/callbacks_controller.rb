class CallbacksController < Devise::OmniauthCallbacksController
  before_action :authenticate_user!, only: :stripe_connect

  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])
    sign_in_and_redirect @user
  end

  def google_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'])
    sign_in_and_redirect @user
  end

  def stripe_connect
    require 'pry'
    binding.pry
    @user = current_user
    if @user.update_attributes(
      provider: request.env['omniauth.auth'].provider,
      uid: request.env['omniauth.auth'].uid,
      access_code: request.env['omniauth.auth'].credentials.token,
      publishable_key: request.env['omniauth.auth'].info.stripe_publishable_key
    )
      # anything else you need to do in response..
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(
        :notice, :success, kind: 'Stripe') if is_navigational_format?
    else
      session['devise.stripe_connect_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end
