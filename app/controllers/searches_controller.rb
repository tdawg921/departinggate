class SearchesController < ApplicationController
	#before_filter :traveller_to_int, :only => [:create]

	def new
		@search = Search.new
		@client_ip = remote_ip()
		@closest_airport = Airport.near(@client_ip, 60, :order => "distance")
	end

	def create
		@search = Search.new(params[:search])
		@search.traveller = params[:search][:traveller].to_i

		if @search.save
			redirect_to @search
		else
			flash.now[:error]
			render action: "new"
		end	
	end

	def show
		@search = Search.find(params[:id])
		@search = @search.cities.page(params[:page])
		@search_params = Search.find(params[:id])
	end

	def index
		@search = Search.order(:id).page(params[:page])
	end


	def traveller_to_int
	  params[:search][:traveller] = params[:search][:traveller].to_i
	end  
end
