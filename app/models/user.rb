class User < ApplicationRecord
  devise :database_authenticatable

  ALGORITHM = 'HS512'.freeze

  def generate_token(exp = true)
    payload = { email: email }
    payload[:exp] = 3600 if exp
    JWT.encode(payload, 
	       Rails.application.credentials[Rails.env.to_sym][:secret_key_base].to_s, 
	       ALGORITHM)
  end
end
