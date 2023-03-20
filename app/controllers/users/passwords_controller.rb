# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  skip_forgery_protection
  respond_to :json

  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  def update
    if current_user.valid_password?(password_params[:current_password])
      pass_change_success = current_user.reset_password(
        password_params[:password],
        password_params[:password_confirmation]
      )
      msg, status = if pass_change_success
        ['Password Changed Successfully', :ok]
      else
        ['An Error Occurred', :unprocessable_entity]
      end
      render json: { message: msg }, status: status
    else
      render json: { message: 'Your Old Password is Incorrect' }, status: :unauthorized
    end
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end
