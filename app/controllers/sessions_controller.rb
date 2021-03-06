class SessionsController < ApplicationController
	def new 
		session[:admin] = nil
		session[:admin_name] = nil

		@user = Staff.find_by_name(params[:name])
		if @user && @user.password_digest == params[:password_digest]
			session[:staff] = @user.id
			session[:staff_name] = @user.name
			redirect_to staff_home_path, notice: 'Logined'
		else	
			redirect_to staff_login_path, notice: 'Invalid login'
		end
	end

	def destroy
		session[:staff] = nil
		session[:staff_name] = nil
		redirect_to staff_login_path, notice: 'Finish Logout'
	end

	def home
		@sales = Sale.all
	end
end
