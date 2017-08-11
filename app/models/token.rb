class Token < ApplicationRecord
  def self.encode(payload, exp = 1.minute.from_now.to_i) #設置過期時間
    JWT.encode(payload, Rails.application.secrets.secret_key_base) #jwt利用secrets.yml中的secret_key_base加密, production: ENV["SECRET_KEY_BASE"]
  end

  def self.decode(token)
    HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.secrets.secret_key_base)[0]) #hash轉換可用symbol
  rescue
    nil
  end
end
