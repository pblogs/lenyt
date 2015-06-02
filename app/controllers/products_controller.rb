class ProductsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def index
    @products = Product.all
    render json: @products
  end

  def show
    @owner = @product.user
  end
end
