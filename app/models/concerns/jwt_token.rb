module JwtToken
  extend ActiveSupport::Concern

  def generate_jwt
    JWT.encode({
                 id: id,
                 exp: 60.days.from_now.to_i,
               }, Rails.application.secrets.secret_key_base)
  end
end
