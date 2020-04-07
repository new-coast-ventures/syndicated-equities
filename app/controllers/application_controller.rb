class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def check_master_admin
    if current_user.admin
      @master_admin = true
    end
  end
end
