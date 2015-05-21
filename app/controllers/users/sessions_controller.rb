class Users::SessionsController < Devise::SessionsController
  respond_to :js
  layout false

  def new
    super
  end

  def create
    self.resource = warden.authenticate(auth_options)
    return unless resource && resource.active_for_authentication?
    sign_in(resource_name, resource)
  end
end
