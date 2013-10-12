class User < ActiveRecord::Base
  attr_accessible :name, :username

  validates_presence_of :name, :username, :password_digest, :session_token
  validates :username, :uniqueness => true

  has_many :inbound_follows,
           :class_name => 'Follows',
           :foreign_key => :follower_id

  has_many :outbound_follows,
           :class_name => 'Follows',
           :foreign_key => :followee_id

  has_many :followers, :through => :inbound_follows, :source => :follower
  has_many :followed_users, :through => :inbound_follows, :source => :followee

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return user if user.is_password?(password_digest)
    nil
  end

  def reset_session_token!
    self.set_session_token
    self.save!
    self.session_token
  end

  def set_session_token
    self.session_token = SecureRandom.urlsafe_64(16)
  end

  def password=(raw_password)
    self.password_digest = BCrypt.Password.create(raw_password)
  end

  def is_password?(pass)
    p = BCrypt.Password.new(self.password_digest)
    p.is_password?(pass)
  end
end
