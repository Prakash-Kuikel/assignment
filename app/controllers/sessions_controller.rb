# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(_resource, _opts = {})
    render json: { message: 'Logged in successfully.' }, status: :ok
  end

  def respond_to_on_destroy
    current_user ? log_out_success : log_out_failure
  end

  def log_out_success
    render json: { message: 'Logged out successfully.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Log out failure.' }, status: :unauthorized
  end
end
