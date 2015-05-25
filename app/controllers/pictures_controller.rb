class PicturesController < ApplicationController
  def index
    @assets = Asset.all
  end


  def create
    @asset = Asset.new(asset_params)

    #TODO add attachable_id: and attachable_type:
    if @asset.save
      render json: { message: "success", fileID: @asset.id }, status: 200
    else
      render json: { error: @asset.errors.full_messages.join(',')}, status: 400
    end
  end

  private

  def asset_params
    params.require(:asset).permit(:image)
  end
end
