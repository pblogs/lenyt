class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    current_user
  end

  def settings
  end

  def messages

  end

  def update
    @user = current_user

    #raise current_user.inspect
    respond_to do |format|
      if @user.update_attributes!(user_params)
        format.html { redirect_to settings_users_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        @user = current_user
        format.html { render action: 'settings' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def upload_avatar
    @user = current_user

    @user.update_attributes(user_params)

    respond_to do |format|
      format.json { render json: @user.to_json }
    end
  end

  def delete_avatar

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username,
      :email, :address, :city, :state, :country,
      :postal_code, :phone_number,
      :image_url, :avatar)
  end
end
