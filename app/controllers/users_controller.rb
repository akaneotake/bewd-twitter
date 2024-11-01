class UsersController < ApplicationController
    # POST /users
    def create
      @user = User.new(user_params)
      if @user.save
        render json: { user: @user }, status: :created
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    # Strong parameters to allow only safe attributes
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
  end
  