require 'bcrypt'
require 'securerandom'

class Api::V0::UsersController < ApplicationController
include BCrypt 

  def create
    @user = User.new(user_params)
    @user.password = params[:password]
    @user.api_key = SecureRandom.uuid 
    if @user.save!
      render json: UserSerializer.new(@user), status: 201
    else
      render json: UserSerializer(@user.errors).error_message
    end
  end

  private
    def password
      @password ||= Password.new(password_hash)
    end

    def password=(new_password)
      @password = Password.create(new_password)
      self.password_hash = @password
    end

    def user_params
      params.require(:user).permit(:email, :password)
    end
end