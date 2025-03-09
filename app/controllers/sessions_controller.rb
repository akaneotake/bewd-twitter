class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:user][:username])

    if @user && @user.password == params[:user][:password]
      session = @user.session.create

      cookies.permanent.signed[:twitter_session_token] = {
        value: session.token,
        httponly: true # クライアント側のJavaScriptからアクセス不可
      }

      render json: {
        success: true
       }, status: :created
    else
      render json: {
        success: false  
      }, status: :unauthorized
    end
  end
end
