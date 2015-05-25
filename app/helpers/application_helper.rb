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

  def user_avatar(user, size='50x50')
    return image_tag(user.avatar.url(:thumb), class: 'img-circle avatar', size: size) if user.avatar.present?
    return image_tag(user.image_url(:thumb), class: 'img-circle img-url', size: size) unless user.image_url.blank?
    image_tag('default_avatar.png', class: 'img-circle missing', size: size)
  end
end
