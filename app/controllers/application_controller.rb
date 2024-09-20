class ApplicationController < ActionController::Base
  before_action :authorize_request, if: :api_request?
  skip_forgery_protection
  protected

  # This method will check if the request is for JSON (API) or not
  def api_request?
    request.format.json? # The correct way to check if it's a JSON request
  end

  # This method will authorize requests for API endpoints
  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
