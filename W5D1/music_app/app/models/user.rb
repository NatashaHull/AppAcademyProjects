class User < ActiveRecord::Base
  attr_accessible :email, :password

  before_validation :set_session_token
  validates :email, :presence => true, :uniqueness => true
  validates :session_token, :activation_token, :presence => true
  validates :password_digest,
            :presence => { :message => "Password can't be blank"}

  has_many :notes

  def self.find_by_credentials(email, pass)
    user = User.find_by_email(email)
    return user if !!user && user.is_password?(pass)
    nil
  end

  def password=(raw_pass)
    #Only sets the password_digest if there is a password
    unless raw_pass.blank?
      self.password_digest = BCrypt::Password.create(raw_pass)
    end
  end

  def is_password?(pass)
    p = BCrypt::Password.new(self.password_digest)
    p.is_password?(pass)
  end

  def activate!
    self.activated = true
    self.save!
  end

  # def make_admin
  #   self.admin = true
  #   self.save!
  # end

  def reset_session_token!
    self.set_session_token
    self.save!
    self.session_token
  end

  def set_session_token
    self.session_token = SecureRandom.urlsafe_base64(16)
  end

  def set_activation_token
    self.activation_token = SecureRandom.urlsafe_base64(16)
  end
end
