class ApplicationController < ActionController::Base
protect_from_forgery

def remote_ip
  	if request.remote_ip == '127.0.0.1' 
		@client_ip = '69.143.203.96'
	else
		@client_ip = request.remote_ip
	end
end

  private
  	def current_user
  		@current_user ||= User.find(session[:user_id]) if session[:user_id]
  	end
  	helper_method :current_user

  	def authorize
  		redirect_to login_url, alert: "Not authorized" if current_user.nil?
  	end
end
