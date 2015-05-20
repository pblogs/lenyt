class Users::SessionsController < Devise::SessionsController

  def new
    super
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)

    respond_to do |format|
      format.html {
        if !session[:return_to].blank?
          redirect_to session[:return_to]
          session[:return_to] = nil
        else
          respond_with resource, :location => after_sign_in_path_for(resource)
        end
      }

      format.js {
        render layout: false
      }
    end
  end
end
