module Api
  class UsersController < ApplicationController
    before_action :authenticate_user!
    respond_to :json

    def current
      render json: current_user, root: nil
    end

    def products
      render json: current_user.products, each_serializer: UserProductsSerializer, root: 'products'
    end
  end
end
