class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def check_master_admin
    if ENV['MASTER_ADMINS'] && ENV['MASTER_ADMINS'].include?(current_user.email)
      @master_admin = true
    end
  end
end
