class UsersController < ApplicationController
    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
          render json: user, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

    def show
        user = User.find_by(username: params[:username])  
        if user&.authenticate(params[:password])
            render json: user, status: :created
        else
            render json: {error: {login: "Invalid username or password"}, status: :unauthorized}
        end
    end
    
      private

  def user_params
    params.permit(:username, :password, :password_confirmation)
  end
end
