module Api
  class CitiesController < ApplicationController
    before_action :authenticate_user!
    respond_to :json

    def index
      if params[:name]
        cities = City.where('name ILIKE ?', "%#{params[:name]}%").first(6)
      else
        cities = []
      end

      render json: cities
    end
  end
end
