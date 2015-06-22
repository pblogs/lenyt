class ListingsController < ApplicationController
  before_action :authenticate_user!
  before_filter :load_product, except: [:index, :new, :create, :search]
  before_filter :validate_owner, except: [:index, :show, :new, :create, :search]

  def index
  end

  def show
  end

  def search
  end

  def new
    @product = Product.new
    @my_unique_token = SecureRandom.hex(16)
  end

  def edit
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

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to listings_url }
      format.json { head :no_content }
    end
  end

  private

  def load_product
    @product = Product.find(params[:id])
  end

  def validate_owner
    unless @product.user == current_user
      flash[:error] = 'You are not authorized to access this page.'
      redirect_to listing_path(@product)
    end
  end

  def product_params
    params.require(:product).permit(:title, :category_id, :user_id,
                                    :tag_list, :price_per_day, :total_value,
                                    :details, :is_available, :available_at,
                                    :end_at, :address, :country, :postal_code, :locality,
                                    :latitude, :longitude, :administrative_area_level_2, :administrative_area_level_1,
                                    :location_type, assets_attributes:[:image])
  end
end
