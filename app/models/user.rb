class User < ApplicationRecord
  devise :database_authenticatable

  ALGORITHM = 'HS512'.freeze

  def generate_token(exp = true)
    payload = { email: email }
    payload[:exp] = 3600 if exp
    JWT.encode(payload, Rails.applications.credentials[:secret], ALGORITHM)
  end
end
