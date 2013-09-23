class User < ActiveRecord::Base
  attr_accessible :password, :token, :username
  
  validates :username, :password, :presence => true
  validates :password, :length => { :minimum => 6 }
  
  has_many :links, 
    :class_name => "Link", 
    :foreign_key => :user_id, 
    :primary_key => :id
  
  def reset_token
    self.token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.token
  end
end
