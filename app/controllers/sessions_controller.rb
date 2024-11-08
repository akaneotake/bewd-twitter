# class SessionsController < ApplicationController
#     # POST /sessions
#     def create
#       # Find the user based on the provided username
#       user = User.find_by(username: params[:user][:username])
  
#       # Authenticate the user with the given password
#       if user && user.authenticate(params[:user][:password])
#         # Generate a new session token
#         session = Session.create!(user: user, token: SecureRandom.hex)
  
#         # Set the session token in cookies
#         cookies[:twitter_session_token] = { value: session.token, httponly: true }
  
#         # Render a success response
#         render json: { success: true }, status: :ok
#       else
#         # Render an error response if authentication fails
#         render json: { success: false, errors: ["Invalid username or password"] }, status: :unauthorized
#       end
#     end


#     def authenticated
#         # Retrieve the token from the cookie
#         session_token = cookies[:twitter_session_token]
    
#         # Find the session in the database based on the token
#         session = Session.find_by(token: session_token)
    
#         if session
#           render json: { message: "User is authenticated", user_id: session.user_id }, status: :ok
#         else
#           render json: { message: "User is not authenticated" }, status: :unauthorized
#         end
#       end

      
#   end
  

class SessionsController < ApplicationController
  # POST /sessions
  def create
    user = User.find_by(username: params[:user][:username])

    if user && user.authenticate(params[:user][:password])
      session = user.sessions.create
      cookies.signed[:twitter_session_token] = { value: session.token, httponly: true }

      render json: { success: true }
    else
      render json: { success: false }, status: :unauthorized
    end
  end

  # GET /authenticated
  def authenticated
    session_token = cookies.signed[:twitter_session_token]
    session = Session.find_by(token: session_token)

    if session && session.user
      render json: {
        authenticated: true,
        username: session.user.username
      }
    else
      render json: { authenticated: false }, status: :unauthorized
    end
  end

  # DELETE /sessions
  def destroy
    session_token = cookies.signed[:twitter_session_token]
    session = Session.find_by(token: session_token)

    if session
      session.destroy
      cookies.delete(:twitter_session_token)
      render json: { success: true }
    else
      render json: { success: false }, status: :unauthorized
    end
  end
end
