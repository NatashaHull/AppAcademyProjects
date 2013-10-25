class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def register(user)
    @user = user
    @url = activate_users_url
    @url += "?activation_token=#{user.activation_token}"
    mail(:to => user.email, :subject => "Welcome to the music app!")
  end
end
