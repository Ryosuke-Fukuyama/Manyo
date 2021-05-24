module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # def admin_user?
  #   @current_user ||= User.find_by(admin: true) if current_user.admin?
  #   @current_user[:admin] if true
  # end

  def logged_in?
    current_user.present?
  end
end
