class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  before_action :login_required

  private

  def login_required
    redirect_to new_session_path,  notice: 'ログインしてください' unless current_user# && session[:id] == params[:id]
  end
end
