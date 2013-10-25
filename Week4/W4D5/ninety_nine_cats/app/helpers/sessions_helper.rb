module SessionsHelper
  def login_user!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout_user!(user)
    user.reset_session_token!
    session[:session_token] = nil
  end

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    redirect_to new_session_url if !current_user
  end
end
