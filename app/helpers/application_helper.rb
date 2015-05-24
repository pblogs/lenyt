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

  def user_avatar(user)
    if user.avatar.present?
      image_tag(user.avatar.url(:thumb), class: 'img-circle avatar', size: '50x50')
    elsif !user.image_url.blank?
      image_tag(user.image_url(:thumb), class: 'img-circle img-url', size: '50x50')
    else
      image_tag('http://placehold.it/100x100', class: 'img-circle missing', size: '50x50')
    end
  end
end
