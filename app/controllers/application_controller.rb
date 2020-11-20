class ApplicationController < ActionController::Base

  before_action :authenticated?
  helper_method :current_user
  helper_method :logged_in?
  helper_method :is_admin?

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def is_admin?
    logged_in? && current_user.role === 'admin'
  end

  def authenticated?
    redirect_to '/welcome', notice: 'You should to log in or sign up' unless logged_in?
  end

  def authorized?
    redirect_to '/welcome', notice: 'Permission denied' unless is_admin?
  end

end
