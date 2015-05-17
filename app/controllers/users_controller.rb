class UsersController < ApplicationController
 # before_action :authenticate_user!

  def profile
    current_user
  end

  def messages

  end
end
