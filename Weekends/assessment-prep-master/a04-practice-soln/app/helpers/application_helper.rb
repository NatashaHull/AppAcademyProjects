module ApplicationHelper
  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by_token(session[:token])
  end

  def logged_in?
    !!current_user
  end

  def authenticate
    redirect_to new_session_url unless logged_in?
  end
end
