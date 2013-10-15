module UsersHelper
  def activated?
    unless current_user.activated
      redirect_to current_user
    end
  end

  def admin?
    unless !!current_user && current_user.admin
      flash[:errors] = ["Only admins can visit this page!"]
      redirect_to root_url
    end
  end
end
