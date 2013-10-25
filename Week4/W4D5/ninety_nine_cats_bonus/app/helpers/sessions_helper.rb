module SessionsHelper
  def login_user!(user)
    session_token = create_session_token(user)
    session[:session_token] = session_token.session_token
  end

  def logout_user!(user)
    user.reset_session_tokens!
    session[:session_token] = nil
  end

  def logout_session!(session)
    session.destroy
  end

  def current_user
    session_token = SessionToken.find_by_session_token(session[:session_token])
    return nil unless session_token
    @current_user ||= session_token.user
  end

  def logged_in?
    redirect_to new_session_url if !current_user
  end

  private

    def create_session_token(user)
      session_token = SessionToken.new()
      session_token.user_id = user.id
      session_token.ip = get_ip
      session_token.device = get_device
      session_token.reset_session_token!
      session_token
    end

    def get_ip
      request.remote_ip
    end

    def get_device
      device_raw = request.env["HTTP_USER_AGENT"]
      device_raw.split(/\(|\)/)[1].split(";").last
    end
end
