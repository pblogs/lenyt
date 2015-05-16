class SessionsController < ApplicationController

  def create
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
