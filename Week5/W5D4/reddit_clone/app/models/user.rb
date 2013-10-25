class User < ActiveRecord::Base
  attr_accessible :email, :password
  attr_reader :password

  before_validation :set_session_token
  validates_presence_of :email, :password_digest, :session_token
  validates :password, :length => { :minimum => 6, :allow_nil => true }
  validates :email, :uniqueness => true

  has_many :links, :foreign_key => :author_id
  has_many :subs, :foreign_key => :moderator_id
  has_many :comments, :foreign_key => :author_id

  def self.find_by_credentials(user_hash)
    user = User.find_by_email(user_hash[:email])
    return user if !!user && user.is_password?(user_hash[:password])
    nil
  end

  def password=(raw_pass)
    @password = raw_pass
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
