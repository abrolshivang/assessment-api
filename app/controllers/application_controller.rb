class ApplicationController < ActionController::API
  attr_accessor :current_user

  def authenticate!
    payload = decode_token(request.headers['X-ACCESS-TOKEN']) 
    @current_user = User.find_by(email: payload["email"])
  end

  def decode_token(token)
    begin
      payload = JWT.decode(token, 
		 Rails.application.credentials[Rails.env.to_sym][:secret_key_base].to_s, 
		 User::ALGORITHM).first
      return [payload, :success]
    rescue JWT::ExpiredSignature
      return [nil, :unauthorized]
    rescue JWT::ImmatureSignature, JWT::DecodeError
      return [nil, :bad_request]
    end
  end
end
