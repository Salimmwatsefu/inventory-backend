class ApplicationController < ActionController::API
  include ActionController::Cookies

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  before_action :authenticate_request # Add this line to call the authentication method

  private

  def authenticate_request
    token = request.headers['Authorization']&.split(' ')&.last
    return render json: { errors: ['Authorization token missing'] }, status: :unauthorized unless token

    secret_key = Rails.application.secrets.secret_key_base
    begin
      decoded_token = JWT.decode(token, secret_key, true, algorithm: 'HS256')
      user_id = decoded_token[0]['user_id']
      @current_user = User.find_by(id: user_id)
    rescue JWT::DecodeError, JWT::VerificationError
      return render json: { errors: ['Invalid token'] }, status: :unauthorized
    end

    render json: { errors: ['User not found'] }, status: :unauthorized unless @current_user
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
