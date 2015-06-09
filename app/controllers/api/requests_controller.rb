module Api
  class RequestsController < ApplicationController
    before_action :authenticate_user!
    before_filter :load_request, only: [:show]
    respond_to :json

    def show
      render json: @product
    end

    def create
      @request = Request.new(request_params)
      if @request.save
        render json: 'success'
      else
        render json: 'fail'
      end
    end

    private

    def load_request
      @product = Product.find(params[:id])
    end

    def request_params
      params.require(:request).permit(
        :renter_id,
        :rentee_id,
        :amount,
        :rent_from_date,
        :rent_to_date)
    end
  end
end
