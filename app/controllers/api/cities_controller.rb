module Api
  class CitiesController < ApplicationController
    before_action :authenticate_user!
    respond_to :json

    def index
      cities = City.where('name ILIKE ?', "%#{params[:name]}%")
      render json: cities
    end
  end
end
