class Api::V1::UsersController < ApplicationController
  def check_user
    if user_signed_in?
      render json: { message: 'User Already logged in', email: current_user.email }
    else
      render json: { message: 'User not signed in' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit
  end
end
