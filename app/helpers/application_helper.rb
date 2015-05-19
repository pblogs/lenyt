module ApplicationHelper

  def twitterized_type(type)
    case type
      when :errors
        "alert-error"
      when :alert
        "alert-warning"
      when :error
        "alert-error"
      when :notice
        "alert-success"
      else
        "alert-info"
    end
  end

  def flash_normal
    render "shared/flashes"
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
