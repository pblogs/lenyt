module Api
  class UsersController < ApplicationController
    before_action :authenticate_user!
    respond_to :json

    def current
      render json: current_user, root: nil
    end

    def update
      @user = current_user

      respond_to do |format|
        if @user.update_attributes!(user_params)
          format.json { head :no_content }
        else
          format.json do
            render json: @user.errors, status: :unprocessable_entity
          end
        end
      end
    end

    def newsletter_notifcations
      user = current_user
      user.update_attributes!(newsletter_notifcations: params[:newsletter])
      render json: {}
    end

    def messages_notifcations
      user = current_user
      user.update_attributes!(messages_notifcations: params[:message])
      render json: {}
    end

    def products
      render json: current_user.products,
        each_serializer: UserProductsSerializer,
        root: 'products'
    end

    private

    def user_params
      params.require(:user).permit(
        :messages_notifcations, :newsletter_notifcations
      )
    end
  end
end
