class TweetsController < ApplicationController
      # GET /tweets
      def index_by_user
        # Retrieve the user based on the provided username
        user = User.find_by(username: params[:username])
    
        if user
          # Get all tweets by that user
          tweets = user.tweets.includes(:user)
    
          # Render the tweets as JSON
          render json: tweets.as_json(include: { user: { only: [:username, :email] } }), status: :ok
        else
          render json: { errors: ["User not found"] }, status: :not_found
        end
      end
      
  def index
    # Retrieve all tweets from the database
    tweets = Tweet.includes(:user).all

    # Render the tweets as JSON, including user details if needed
    render json: tweets.as_json(include: { user: { only: [:username, :email] } }), status: :ok
  end
    # POST /tweets
    def create
      # Retrieve the session token from the cookie
      session_token = cookies[:twitter_session_token]
  
      # Find the session based on the token
      session = Session.find_by(token: session_token)
  
      if session
        # Retrieve the current user from the session
        current_user = session.user
  
        # Create a new tweet associated with the current user
        tweet = current_user.tweets.new(tweet_params)
  
        if tweet.save
          render json: { message: "Tweet created successfully", tweet: tweet }, status: :created
        else
          render json: { errors: tweet.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { errors: ["User not authenticated"] }, status: :unauthorized
      end
    end
  
    def destroy
        # Retrieve the session token from the cookie
        session_token = cookies[:twitter_session_token]
    
        # Find the session based on the token
        session = Session.find_by(token: session_token)
    
        if session
          # Retrieve the current user from the session
          current_user = session.user
    
          # Find the tweet by ID
          tweet = Tweet.find_by(id: params[:id])
    
          if tweet && tweet.user_id == current_user.id
            # Delete the tweet if the current user is the author
            tweet.destroy
            render json: { message: "Tweet deleted successfully" }, status: :ok
          else
            render json: { errors: ["Tweet not found or you are not authorized to delete this tweet"] }, status: :forbidden
          end
        else
          render json: { errors: ["User not authenticated"] }, status: :unauthorized
        end
      end
    private
  
    # Strong parameters for tweet creation
    def tweet_params
      params.require(:tweet).permit(:message)
    end
  end
  