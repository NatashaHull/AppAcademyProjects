module SessionsHelper

  def current_user
    @current_user ||= User.find_by_session_token(session[:token])
  end

  def logged_in?
    !!current_user
  end

  def log_in_user!(user)
    session[:token] = user.reset_session_token!
  end

  def log_out_user!(user)
    user.reset_session_token!
    session[:token] = nil
  end

  def must_be_logged_in
    redirect_to new_session_url unless logged_in?
  end

end
