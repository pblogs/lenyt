module Api
  class AssetsController < ApplicationController
    before_action :authenticate_user!
    respond_to :json

    def destroy
      product = current_user.products.where(id: params[:product_id]).first
      return render json: { message: 'Product not found' }, status: 404 unless product.present?

      asset = product.assets.where(id: params[:id]).first
      return render json: { message: 'Asset not found' }, status: 404 unless asset.present?

      if asset.destroy
        asset.image.clear
        render json: { message: 'success' }, status: 200
      else
        render json: { message: 'Could not delete image' }
      end
    end
  end
end
