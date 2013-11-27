class SearchesController < ApplicationController

	def new
		@search = Search.new
		@client_ip = remote_ip()
		@closest_airport = Airport.near(@client_ip, 60, :order => "distance")
	end

	def create
		@search = Search.new(params[:search])

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

end
