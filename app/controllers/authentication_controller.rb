class AuthenticationController < ApplicationController
  def create
    if user = User.find_by(email: user_params[:email]).try(:authenticate, user_params[:password])
      render json: user.token
    else
      render json: {errors: ['wrong user or password']}, status: :unauthorized
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
