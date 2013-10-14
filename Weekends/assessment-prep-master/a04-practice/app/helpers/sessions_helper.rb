module SessionsHelper
  def login_user!(user)
    session[:session_token] = user.reset_session_token!
  end

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logout_user!(user)
    user.reset_session_token!
    session[:session_token] = nil
  end

  def logged_in?
    if !current_user
      flash[:errors] = ["You must be logged in to view this page!"]
      redirect_to new_session_url
    end
  end
end
