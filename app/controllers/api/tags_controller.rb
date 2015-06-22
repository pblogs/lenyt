module Api
  class TagsController < ApplicationController
    before_action :authenticate_user!
    respond_to :json

    def index
      tags = Tag.all
      render json: tags
    end
  end
end
