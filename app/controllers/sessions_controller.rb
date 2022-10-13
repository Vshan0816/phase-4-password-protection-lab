class SessionsController < ApplicationController
    def create
        user = User.find_by(id: session[:user_id])
        if user
        render json: user
        else
        render json: { error: "Not authorized" }, status: :unauthorized
        end
    end

    def destroy
        session.delete :user_id
        head :no_content 
    end
end
