class TweetsController < ApplicationController
  def create
    token = cookies.signed[:session_token]
    session = Session.find_by(token: token)

    if session
      user = session.user
      @tweet = user.tweets.new(tweet_params)

      if @tweet.save
        render 'tweets/create'
      else
        render json: { success: false }
      end
    else
      render json: { success: false }
  end
end

private

  def tweet_params
    params.require(:tweet).permit(:message)
  end