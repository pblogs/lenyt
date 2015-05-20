class Users::SessionsController < Devise::SessionsController

  def new
    super
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    if !session[:return_to].blank?
      redirect_to session[:return_to]
      session[:return_to] = nil
    else
      respond_with resource, :location => after_sign_in_path_for(resource)
    end
  end


  def create2
    user = User.find_by_email(params[:user][:email])
    self.resource = warden.authenticate(auth_options)

   # self.resource = warden.authenticate!(auth_options)

    respond_to do |format|
      format.html {
        set_flash_message(:notice, :signed_in) if is_flashing_format?
        sign_in(resource_name, resource)

        yield resource if block_given?
        respond_with resource, location: after_sign_in_path_for(resource)
      }
      format.js {
        sign_in(resource_name, resource)
        render layout: false
      }
    end

  end
end
