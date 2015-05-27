class PicturesController < ApplicationController
  def index
    @assets = Asset.all
  end


  def create
    @asset = Asset.new(asset_params)
    @asset.unit_token = params[:my_unit_token]

    if @asset.save
      render json: {
        message: 'success',
        id: @asset.id,
        url: @asset.image.url
      }, status: 200
    else
      render json: { error: @asset.errors.full_messages.join(',')}, status: 400
    end
  end

  private

  def asset_params
    params.require(:asset).permit!
  end
end
