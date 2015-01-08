class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def current_user
  	Rails.logger.info("current user? #{session.inspect}")
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :all
end
