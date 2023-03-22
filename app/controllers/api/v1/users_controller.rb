class Api::V1::UsersController < ApplicationController
  skip_forgery_protection
  before_action { ActiveStorage::Current.url_options = { host: request.base_url } }
  before_action :authenticate_user!

  def check_user
    render json: { message: 'User Already logged in', email: current_user.email }
  end

  def add_files
    current_user.file_lists.create!(parsed_params)
    render json: { message: 'Files Has been uploaded Successfully' }, status: :created
  rescue StandardError
    render json: { message: 'An Error Occurred' }, status: :unprocessable_entity
  end

  def user_files
    @files = current_user.file_lists
  end

  def delete_file
    f = FileList.find(params[:id])
    if current_user == f.user
      f.destroy
    else
      render json: { message: 'Not Authorized' }, status: :unauthorized
    end
  end

  def show_public_files
    @files = FileList.where.not(user_id: current_user.id).and(FileList.where(private: false))
  end

  def copy_file
    file_list = FileList.find(params[:id])
    f = current_user.file_lists.create!(file_list.attributes.reject { |k, _v| k.to_s == 'id' })
    f.file.attach(
      {
        io: StringIO.new(file_list.file.blob.download),
        filename: file_list.file.blob.filename,
        content_type: file_list.file.blob.content_type
      }
    )
    render json: { message: 'Files Has been Copied Successfully' }, status: :created
  rescue StandardError
    render json: { message: 'An Error Occurred' }, status: :unprocessable_entity
  end

  def toggle_private_file
    f = FileList.find(params[:id])
    if current_user == f.user
      f.update(private: !f.private)
    else
      render json: { message: 'Not Authorized' }, status: :unauthorized
    end
  end

  private

  def parsed_params
    file_lists = []
    params[:file].each_with_index { |f, index| file_lists.append({ private: params[:private][index], file: f }) }
    file_lists
  end
end
