module SessionsHelper
  def login_user!
    session[:token] = @user.reset_session_token!
  end

  def logout_user!
    current_user.reset_session_token!
    session[:token] = nil
  end

  def current_user
    @current_user ||= User.find_by_session_token(session[:token])
  end
end
