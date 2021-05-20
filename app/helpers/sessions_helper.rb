module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def admin_user
    @current_user ||= User.find_by(admin: true)
  end

  def logged_in?
    current_user.present? # || admin_user.present?
  end
end
