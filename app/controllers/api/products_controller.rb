module Api
  class ProductsController < ApplicationController
    before_action :authenticate_user!
    before_filter :load_product, only: [:show]
    respond_to :json

    def index
      if params[:search]
        @products = Product.search(params[:search])
      else
        @products = Product.paginate(page: params[:page], per_page: 6)
      end

      render json: @products, each_serializer: ProductsSerializer
    end

    def show
      owner = @product.user
      voted = Rate.where(
        rater_id: current_user.id, rateable_id: owner.id
      ).first.present?
      request_sent = Request.where(
        renter_id: owner.id,
        rentee_id: current_user.id
      ).first.present?

      render json: @product,
        voted: voted,
        owner: owner,
        request_sent: request_sent
    end

    private

    def load_product
      @product = Product.find(params[:id])
    end
  end
end
