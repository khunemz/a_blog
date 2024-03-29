class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
  end

  def logged_in?
  	!!current_user
  end

  def require_user
  	if !logged_in?
  		redirect_to new_session_path, notice: 'กรุณาลงชื่อเข้าระบบก่อน' 
  	end
  end
end
