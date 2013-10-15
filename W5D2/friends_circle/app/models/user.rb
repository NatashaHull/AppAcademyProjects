class User < ActiveRecord::Base
  attr_accessible :email, :password
  attr_reader :password

  before_validation :set_session_token
  validates :email, :password_digest, :session_token, :presence => true
  validates :password, :length => { :minimum => 6, :allow_nil => true }

  def self.find_by_credentials(user_hash)
    user = User.find_by_email(user_hash[:email])
    return user if !!user && user.is_password?(user_hash[:password])
    nil
  end

  def password=(raw_pass)
    self.password_digest = BCrypt::Password.create(raw_pass)
  end

  def is_password?(pass)
    BCrypt::Password.new(self.password) == pass
  end

  def reset_session_token!
    self.set_session_token
    self.save
    self.session_token
  end

  def set_session_token
    self.session_token = SecureRandom.urlsafe_base64(16)
  end
end
