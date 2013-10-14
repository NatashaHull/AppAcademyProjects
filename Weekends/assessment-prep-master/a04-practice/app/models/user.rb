class User < ActiveRecord::Base
  attr_accessible :username, :password
  attr_reader :password

  before_validation :set_session_token
  validates_presence_of :username, :password_digest, :session_token

  has_many :links

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return user if !!user && user.is_password?(password)
    nil
  end

  def password=(raw_pass)
    self.password_digest = BCrypt::Password.create(raw_pass)
  end

  def is_password?(pass)
    p = BCrypt::Password.new(self.password_digest)
    p.is_password?(pass)
  end

  def reset_session_token!
    set_session_token
    self.save!
    self.session_token
  end

  def set_session_token
    self.session_token = SecureRandom.urlsafe_base64(16)
  end
end
