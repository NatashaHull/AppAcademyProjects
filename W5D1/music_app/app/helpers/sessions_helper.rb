module SessionsHelper
  def current_user
    User.find_by_session_token(session[:token])
  end

  def logged_in?
    unless !!current_user
      redirect_to new_session_url
    end
  end

  def login_user!(user)
    session[:token] = user.reset_session_token!
  end

  def logout_user!(user)
    user.reset_session_token!
    session[:token] = nil
  end
end
