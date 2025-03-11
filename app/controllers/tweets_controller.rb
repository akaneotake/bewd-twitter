class TweetsController < ApplicationController
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

private

  def tweet_params
    params.require(:tweet).permit(:message)
  end