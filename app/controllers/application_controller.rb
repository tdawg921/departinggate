class ApplicationController < ActionController::Base
protect_from_forgery

def remote_ip
  	if request.remote_ip == '127.0.0.1' 
		@client_ip = '69.143.203.96'
	else
		@client_ip = request.remote_ip
	end
end

end
