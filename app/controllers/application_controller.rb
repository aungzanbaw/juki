class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
   	
 	
 	def authenticate
    if session['admin'].nil?
      redirect_to root_path
    end
  end

  def authenticate_staff
    if session['staff'].nil?
      redirect_to staff_login_path
    end
  end
end
