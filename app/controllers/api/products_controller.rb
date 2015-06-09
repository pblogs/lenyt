module Api
  class ProductsController < ApplicationController
    before_action :authenticate_user!
    before_filter :load_product, only: [:show]
    respond_to :json

    def index
      @products = Product.paginate(page: params[:page], per_page: 6)
      render json: @products, each_serializer: ProductsSerializer
    end

    def show
      # TODO: Send owner as parameter to serializer
      owner = @product.user
      voted = Rate.where(
        rater_id: current_user.id, rateable_id: owner.id
      ).present? ? true : false

      render json: @product, voted: voted, owner: owner
    end

    private

    def load_product
      @product = Product.find(params[:id])
    end
  end
end
