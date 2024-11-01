class SessionsController < ApplicationController
    # POST /sessions
    def create
      user = User.find_by(username: params[:user][:username])
  
      # Check if user exists and password is correct
      if user&.authenticate(params[:user][:password])
        # Create a new session for the user
        session = user.sessions.create!(token: SecureRandom.hex(20))
  
        # Set the session token as a permanent cookie
        cookies.permanent[:twitter_session_token] = session.token
  
        render json: { message: "Login successful" }, status: :created
      else
        render json: { errors: ["Invalid username or password"] }, status: :unauthorized
      end
    end
  end
  