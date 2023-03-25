class Users::SessionsController < Devise::SessionsController
  skip_forgery_protection
  respond_to :json
  skip_before_action :verify_signed_out_user, only: :destroy

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    signed_out ? log_out_success : log_out_failure
  end

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: { message: 'You are logged in.' }, status: :ok
    else
      render json: { message: 'You are not logged in.' }, status: :not_found
    end
  end

  def log_out_success
    render json: { message: 'You are logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Hmm nothing happened.' }, status: :unauthorized
  end
end
