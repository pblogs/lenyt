class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :publish_session

  protected

  def publish_session
    return unless current_user.present?
    return if session[:publish_session] == true
    $redis.publish('sess', {
        session: session[:session_id],
        user_id: current_user.id
      }.to_json
    )
    session[:publish_session] = true
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end
end
