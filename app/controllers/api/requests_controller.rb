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
      date_from = Date.strptime(params[:request][:rent_from_date])
      date_to = Date.strptime(params[:request][:rent_to_date])

      daily_rent_rate = product.price_per_day
      days_for_rent = (date_to - date_from).to_i
      amount = daily_rent_rate * 0.15 + days_for_rent * daily_rent_rate * 0.03

      request.rentee_id = current_user.id
      request.renter_id = product.user_id
      request.amount = amount

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
