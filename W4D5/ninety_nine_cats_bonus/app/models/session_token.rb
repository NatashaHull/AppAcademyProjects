class SessionToken < ActiveRecord::Base
  validates_presence_of :user_id, :ip, :device, :session_token

  belongs_to :user

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end
end
