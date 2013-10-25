class ApplicationController < ActionController::Base
  include SessionsHelper


  def must_be_logged_in
    if !current_user
      redirect_to new_session_url
    end
  end

  protect_from_forgery
end
