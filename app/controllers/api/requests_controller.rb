module Api
  class RequestsController < ApplicationController
    before_action :authenticate_user!
    before_filter :load_request, only: [:show]
    respond_to :json

    def show
      render json: @request
    end

    def create
      product = Product.find(params[:request][:product_id])
      request = Request.new(request_params)
      request.rentee_id = current_user.id
      request.renter_id = product.user_id

      if request.save
        render json: {status: 'success'}
      else
        render json: request.errors
      end
    end

    private

    def load_request
      @request = Request.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        return render json: { status: 'not found' }
    end

    def request_params
      params.require(:request).permit(
        :product_id,
        :amount,
        :rent_from_date,
        :rent_to_date,
        :insurance)
    end
  end
end
