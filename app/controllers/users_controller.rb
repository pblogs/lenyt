class UsersController < ApplicationController
 before_action :authenticate_user!

  def profile
    current_user
  end

  def settings
  end

  def update
    @user = current_user

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to settings_users_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'settings' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :address, :city, :state, :country, :postal_code, :phone_number, :image_url)
  end
end
