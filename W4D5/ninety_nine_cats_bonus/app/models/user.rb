class User < ActiveRecord::Base
  attr_accessible :username, :password

  validates_presence_of :username, :password_digest


  has_many :session_tokens
  has_many :cats,
           :foreign_key => :owner_id

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return user if !!user && user.is_password?(password)
    nil
  end

  def reset_session_tokens!
    transaction do
      self.session_tokens.each do |token|
        token.destroy
      end
    end
  end

  def password=(raw_password)
    self.password_digest = BCrypt::Password.create(raw_password)
  end

  def is_password?(pass)
    p = BCrypt::Password.new(self.password_digest)
    p.is_password?(pass)
  end
end
