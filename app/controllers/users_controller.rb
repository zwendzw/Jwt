class UsersController < ApplicationController
  before_action :authenticate!, only:[:index] #執行application_controller的authenticate!
  def index
    render json: current_user.to_json
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: {status: 'successfully'}, status: :successful
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
