class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:user][:username])

    if @user && @user.password == params[:user][:password]
      session = @user.sessions.create

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
    session_token = cookies.permanent.signed[:twitter_session_token]  # Cookieからトークンを取得
    session = Session.find_by(token: session_token) # データベースで検索

    if session
      user = session.user
      render json: {
        authenticated: true,
        username: user.username
      }
    else
      render json: {
        authenticated: false
      }, status: :unauthorized
    end
  end

  def destroy
    session_token = cookies.permanent.signed[:twitter_session_token]  # Cookie からトークンを取得
    session = Session.find_by(token: session_token) # セッションを検索

    if session
      session.destroy  # セッションを削除（ログアウト）
      cookies.delete(:session_token)  # Cookieも削除
      render json: {
        success: true 
      }, status: :ok
    else
      render json: {
        success: false  
      }, status: :unauthorized
    end
  end
end
