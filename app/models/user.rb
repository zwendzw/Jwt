class User < ApplicationRecord
  has_secure_password

  before_save :downcase_email
  before_create :generate_confirmation_instructions

  validates_presence_of :email #空值
  validates_uniqueness_of :email, case_sensitive: false #唯一
  validates_format_of :email, with: /@/ #email格式

  def downcase_email
    self.email = self.email.delete(' ').downcase
  end

  def generate_confirmation_instructions #註冊開通驗證用, todo:mailer
    self.confirmation_token = generate_token
    self.confirmation_sent_at = Time.now.utc
  end
  
  def token
    {token: Token.encode(user_id: self.id)}
  end
  
  def to_json
    self.slice(:name, :email)
  end

  def generate_token
    SecureRandom.hex(10)
  end
end
