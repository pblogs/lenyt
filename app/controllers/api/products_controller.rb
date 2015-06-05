module Api
  class ProductsController < ApplicationController
    before_action :authenticate_user!
    before_filter :load_product, only: [:show]
    respond_to :json

    def index
      @products = Product.paginate(:page => params[:page], :per_page => 6)
      render json: @products, each_serializer: ProductsSerializer
    end

    def show
      @owner = @product.user
      render json: @product
    end

    private

    def load_product
      @product = Product.find(params[:id])
    end
  end
end
