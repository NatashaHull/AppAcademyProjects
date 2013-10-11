class SessionToken < ActiveRecord::Base
  # attr_accessible :title, :body

  #set :ip in controller and pass as parameter via request.remote_ip and @session_token.ip = request.remote_ip
end
