class AuthenticationController < ApplicationController

    def login 
        user = User.find_by(username: params[:username])
        if (!user)
            render json: {error: "Unauthorized"}, status: :unauthorized
        else 
            if (user.authenticate(params[:password]))
                secret_key = Rails.application.credentials.secret_key_base
                token = JWT.encode({
                    user_id: user.id,
                    username: user.username
                }, secret_key)
                render json: {username: user.username, token: token}
            else 
                render json: {error: "Unauthorized"}, status: :unauthorized
            end 
        end     
    end 
end
