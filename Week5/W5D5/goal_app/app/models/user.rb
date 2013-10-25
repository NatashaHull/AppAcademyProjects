class User < ActiveRecord::Base
  attr_accessible :password, :username
  attr_reader :password

  validates :username, :password_digest, :session_token, presence: true
  validates :password, :length => { minimum: 6, :allow_nil => true }
  before_validation :set_session_token, on: :create

  has_many :goals
  has_many :cheers

  def password=(pass)
    @password = pass
    self.password_digest = BCrypt::Password.create(pass)
  end

  def is_password?(password)
    password_obj = BCrypt::Password.new(self.password_digest)
    password_obj.is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return user if !!user && user.is_password?(password)
  end

  def set_session_token
    self.session_token = SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end
end
