module SessionsHelper

  def current_user
    @current_user ||= User.find_by_session_token(session[:token])
  end

  def login_user(user)
    session[:token] = user.reset_session_token
  end

  def logged_in?
    !!current_user
  end

  def logout_user(user)
    user.reset_session_token
    session[:token] = nil
  end

  def require_user
    redirect_to new_session_url unless logged_in?
  end
end
