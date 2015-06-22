module Api
  class TagsController < ApplicationController
    # before_action :authenticate_user!
    respond_to :json

    def index
      if params[:name]
        tags = Tag.where('name ILIKE ?', "%#{params[:name]}%").first(4)
      else
        tags = []
      end
      render json: tags
    end
  end
end
