class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user # 各アクションの前に実行

  def authenticate_user
    token = cookies.signed[:session_token] # クッキーからsession_token を取得
    session = Session.find_by(token: token) # データベースでセッションを検索

    if session
      @current_user = session.user # 認証成功時にユーザーをセット
    else
      render json: { 
        success: false
      }, status: :unauthorized
    end
  end
end
