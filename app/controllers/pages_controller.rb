class PagesController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def home
    render json: { message: 'Nothing is here'}
  end
end
