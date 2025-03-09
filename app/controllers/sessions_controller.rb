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

  def authenticated
    session_token = cookies.permanent.signed[:session_token]  # Cookie からトークンを取得
    session= Session.find_by(token: session_token) # データベースで検索

    if session
      user = session.user
      render json: {
        authenticated: true
        username: user.username 
      }
    else
      render json: {
        authenticated: false
      }
    end
  end
end
