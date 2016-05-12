class HomeController < ApplicationController
	
	def index
		if session[:admin].nil?  
			render :admin_login 
		else
			@machines = []
			machines_loop = Machine.all
			machines_loop.each do |machine|
				if machine.stock > machine.qty
					@machines << machine
				end
			end

			@needles = []
			needles_loop = Needle.all
			needles_loop.each do |needle|
				if needle.stock > needle.qty
					@needles << needle
				end
			end

			@parts = []
			parts_loop = Part.all
			parts_loop.each do |part|
				if part.stock > part.qty
					@parts << part
				end
			end

		end 
	end 

	def admin_login
		@user = Admin.find_by_name(params[:name])
		if @user && @user.password_digest == params[:password_digest]
			session[:admin] = @user.id
			session[:admin_name] = @user.name
			redirect_to root_path, notice: 'Logined' 
		end
	end 

	def destroy
		session[:admin] = nil
		session[:admin_name] = nil
		redirect_to root_path 
	end

end