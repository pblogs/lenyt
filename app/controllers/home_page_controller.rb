class HomePageController < ApplicationController

  layout 'homepage'

  def index
    if current_user.present?
      $redis.publish('sess', {session: request.session_options[:id], user_id: current_user.id}.to_json)
    end
  end
end
