class SearchesController < ApplicationController

	def new
		@search = Search.new
		@client_ip = remote_ip()
		@closest_airport = Airport.near(@client_ip, 60, :order => "distance")
	end

	def create
		params[:search][:depart_date] = Date.parse(params[:search][:depart_date]).to_formatted_s(:db)
		@search = Search.create!(params[:search])
		redirect_to @search
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
