class ApplicationController < ActionController::API
  attr_accessor :current_user

  def authenticate!
    payload = decode_token(request.headers["X-ACCESS-TOKEN"]) 
    @current_user = User.find_by(email: payload[:email])
  end

  def decode_token(token)
    begin
      JWT.decode(token, Rails.applications.credentials[:secret], User::ALGORITHM).first
    rescue JWT::ExpiredSignature
      render(json: { msg: I18n.t('jwt.expired')}, status: :unauthorized) && return
    rescue JWT::ImmatureSignature
      render(json: { msg: I18n.t('jwt.invalid')}, status:  :bad_request) && return
    end 
  end
end
