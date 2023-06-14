require 'securerandom'

class Api::V0::UsersController < ApplicationController
  wrap_parameters :user, include: [:email, :password, :password_confirmation]
  rescue_from ActionController::ParameterMissing, with: :not_raw_json

  def create
    @user = User.new(user_params)
    @user.api_key = SecureRandom.uuid 
    if @user.save
      render json: UserSerializer.new(@user), status: 201
    else
      render json: ErrorSerializer.new(@user.errors).user_error_messages, status: 400
    end
  end

  def login
    @user = User.find_by_email(user_params[:email])
    if @user 
      if @user.authenticate(user_params[:password])
        render json: UserSerializer.new(@user), status: 200
      else
        render json: ErrorSerializer.new(@user.errors).email_password_combination_incorrect, status: 400
      end
    else
      render json: ErrorSerializer.new(@user).email_password_combination_incorrect, status: 400
    end
  end
  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def not_raw_json(error)
      render json: ErrorSerializer.new(error).parameters_not_in_raw_json_body, status: 400
    end
end