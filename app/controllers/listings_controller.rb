class ListingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all
  end


  def search

  end

  def new
    @product = Product.new
    @my_unique_token = SecureRandom.hex(16)
  end

  def edit
    @product = current_user.products.find(params[:id])
    @my_unique_token = SecureRandom.hex(16)
  end

  def create
    @product = current_user.products.new(product_params)

    respond_to do |format|
      if @product.save
        @product.take_assets(params[:my_unique_token])
        format.html { redirect_to listing_path(@product), notice: 'Product was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product}
      else
        @my_unique_token = SecureRandom.hex(16)
        format.html { render action: 'new', error: 'Error....' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @product = current_user.products.find(params[:id])

    respond_to do |format|
      if @product.update(product_params)
        @product.take_assets(params[:my_unique_token])
        format.html { redirect_to listing_path(@product), notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        @my_unique_token = SecureRandom.hex(16)
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @product = current_user.products.find(params[:id])
  end

  def destroy
    @product = current_user.product.find(params[:id])

    @product.destroy
    respond_to do |format|
      format.html { redirect_to listings_url }
      format.json { head :no_content }
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :category_id, :user_id,
                                    :tag_list, :price_per_day, :total_value,
                                    :details, :is_available, :available_at,
                                    :end_at, :address, :country, :postal_code, :locality,
                                    :latitude, :longitude, :administrative_area_level_2, :administrative_area_level_1,
                                    :location_type, assets_attributes:[:image])
  end
end
