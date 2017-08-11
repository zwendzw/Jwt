class ApplicationController < ActionController::API
  attr_accessor :current_user

  protected
  def authenticate!
    render_failed && return if !token?
    @current_user = User.find_by(id: auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
  end

  private
  def render_failed(messages = ['failed to authenticate'])
    render json: { errors: messages}, status: :unauthorized
  end

  def http_token
    @http_token ||= if request.headers['Authorization'].present?
      request.headers['Authorization'].split(' ')[1]
    end
  end

  def auth_token
    @auth_token ||= Token.decode(http_token)
  end

  def token?
    http_token && auth_token && auth_token[:user_id].to_i
  end

end
