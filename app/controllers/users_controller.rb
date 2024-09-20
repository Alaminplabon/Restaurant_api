class UsersController < ApplicationController
    before_action :authorize_request, except: [:login, :signup]
  
    def login
      @user = User.find_by_email(params[:email])
      if @user&.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: @user.id)
        render json: { token: token, message: 'Successfully logged in' }, status: :ok
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end


    def signup
      @user = User.new(signup_params)
      if @user.save
        token = JsonWebToken.encode(user_id: @user.id)
        render json: { token: token, message: 'Account created successfully' }, status: :created
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end


    private
    def signup_params
      params.require(:users).permit(:email, :password)
    end
  end
  