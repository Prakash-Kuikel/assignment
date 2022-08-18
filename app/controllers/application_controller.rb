# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ApiErrors::ErrorHandler
  include ActionController::MimeResponds

  before_action :authenticate_user!

  respond_to :json

  def respond_with(resource, _opts = {})
    if resource.is_a?(Hash) then super
    elsif resource.errors.present? then render json: error_message, status: :unprocessable_entity
    else
      render json: user_params(resource)
    end
  end

  def error_message
    { errors: resource.errors.full_messages }
  end
end
