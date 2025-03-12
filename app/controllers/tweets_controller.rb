class TweetsController < ApplicationController
  def create
    token = cookies.signed[:twitter_session_token]
    session = Session.find_by(token: token)

    if session 
      user = session.user
      @tweet = user.tweets.new(message: params[:tweet][:message])

      if @tweet.save
        render 'tweets/create'
      else
        render json: {
          success: false
        }
      end
    
    else
      render json: {
        success: false
      }
    end
  end

  def destroy
    token = cookies.signed[:twitter_session_token]
    session = Session.find_by(token: token)

    if session 
      user = session.user
      @tweet = user.tweets.find_by(id: params[:id]) 

      if @tweet&.destroy
        render json: { success: true }
      else
        render json: { success: false }
      end
    end
  end

  def index
    @tweets = Tweet.includes(:user).order(created_at: :desc) # すべてのツイートを取得（ユーザー情報を含む）
    render 'tweets/index'
  end

  # 指定したユーザーのツイート一覧を取得
  def index_by_user
    user = User.find_by(username: params[:username]) # ユーザー名で検索

    if user
      @tweets = user.tweets.order(created_at: :desc) # ユーザーのツイートを取得（最新順）
      render 'tweets/index_by_user' # Jbuilder を使用
    else
      render json: {
        tweets: [],
        success: false
      }
    end
  end
end