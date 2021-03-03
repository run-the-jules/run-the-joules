class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  # before_action :authenticate_user!

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def check_user
    redirect_to new_user_session_path unless current_user
  end
end
