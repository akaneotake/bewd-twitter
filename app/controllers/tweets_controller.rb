class TweetsController < ApplicationController
  skip_before_action :authenticate_user, only: [:index] # indexアクションは認証不要

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

private

  def tweet_params
    params.require(:tweet).permit(:message)
  end