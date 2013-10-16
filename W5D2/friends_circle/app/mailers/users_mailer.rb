class UsersMailer < ActionMailer::Base
  default from: "from@example.com"

  def reset_email(user)
    @user = user
    @url = reset_password_users_url
    @url += "?reset_token=#{@user.reset_token}"

    mail(:to => @user.email, :subject => "Rest Password")
  end
end
