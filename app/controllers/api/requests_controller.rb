module Api
  class RequestsController < ApplicationController
    before_action :authenticate_user!
    before_filter :load_request, only: [:show]
    respond_to :json

    def show
      render json: @request
    end

    def create
      @request = Request.new(request_params)
      if @request.save
        render json: {status: 'success'}
      else
        render json: @request.errors
      end
    end

    private

    def load_request
      @request = Request.find(params[:id])
    end

    def request_params
      params.require(:request).permit(
        :renter_id,
        :rentee_id,
        :product_id,
        :amount,
        :rent_from_date,
        :rent_to_date,
        :insurance)
    end
  end
end
