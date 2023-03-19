class Api::V1::UsersController < ApplicationController
  skip_forgery_protection

  def check_user
    if user_signed_in?
      render json: { message: 'User Already logged in', email: current_user.email }
    else
      render json: { message: 'User not signed in' }, status: :unauthorized
    end
  end

  def add_files
    current_user.file_lists.create(parsed_params)
    render json: { message: 'Files Has been uploaded Successfully' }, status: :created
  rescue StandardError
    render json: { message: 'An Error Occurred' }, status: :unprocessable_entity
  end

  private

  def parsed_params
    file_lists = []
    params[:file].each_with_index { |f, index| file_lists.append({ private: params[:private][index], file: f }) }
    file_lists
  end
end
