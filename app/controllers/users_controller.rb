class UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [:create, :login]
  
    def create
        user = User.create!(user_params)
        render json: user, status: :created
      end


    def login
      user = User.find_by(name: params[:name])
      if user&.authenticate(params[:password])
        token = generate_token(user.id) # Generate a token for the user
        render json: { user: user, token: token }, status: :ok
      else
        render json: { errors: ["Invalid username or password"] }, status: :unauthorized
      end
    end
  
    def show
      render json: @current_user
    end
  
    
    private
  
    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end
  
    def generate_token(user_id)
      # Generate a token using JWT with an expiration time (e.g., 1 hour from now)
      secret_key = Rails.application.secrets.secret_key_base
      expiration_time = 5.hour.from_now.to_i
      payload = { user_id: user_id, exp: expiration_time } # 'exp' is the expiration time attribute
      token = JWT.encode(payload, secret_key, 'HS256')
      token
    end
  end
  