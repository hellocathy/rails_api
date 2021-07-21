class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::RequestForgeryProtection

  protect_from_forgery with: :null_session, unless: -> { Rails.env.test? }
  before_action :authenticate, unless: -> { Rails.env.test? }

  protected

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |_token, options|
      token = Base64.strict_encode64(_token)
      @user = ApiUser.find_by(token: token)
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: { error: 'Bad credentials' }, status: 401
  end

  def permitted_parameters
    raise NotImplementedError
  end
end
