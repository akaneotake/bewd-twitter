class TweetsController < ApplicationController
  skip_before_action :authenticate_user, only: [:index, :index_by_user] # 認証不要

  def create
    @tweet = @current_user.tweets.new(tweet_params)

    if @tweet.save
      render 'tweets/create'
    else
      render json: {
        success: false
      }
    end
  end

  def destroy
    @tweet = @current_user.tweets.find_by(id: params[:id]) 

    if @tweet
      @tweet.destroy

      render json: {
        success: true
      }
    else
      render json: {
        success: false
      }
    end
  end

  def index
    @tweets = Tweet.includes(:user).order(created_at: :desc) # すべてのツイートを取得（ユーザー情報を含む）
    render :index # Jbuilder を使用
  end

  # 指定したユーザーのツイート一覧を取得
  def index_by_user
    user = User.find_by(username: params[:username]) # ユーザー名で検索

    if user
      @tweets = user.tweets.order(created_at: :desc) # ユーザーのツイートを取得（最新順）
      render :index_by_user # Jbuilder を使用
    else
      render json: {
        success: false
      }
    end
  end

  private

    def tweet_params
      params.require(:tweet).permit(:message)
    end
end