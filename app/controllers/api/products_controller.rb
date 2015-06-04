module Api
  class ProductsController < ApplicationController
    before_action :authenticate_user!
    respond_to :json

    def index
      @products = Product.paginate(:page => params[:page], :per_page => 6)
      render json: @products
    end

    def show
      @owner = @product.user
    end
  end
end
