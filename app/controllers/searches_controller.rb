class SearchesController < ApplicationController

	def new
		@search = Search.new
	end

	def create
		@search = Search.create!(params[:search])
		redirect_to @search
	end

	def show
		@search = Search.find(params[:id])
		@search = @search.cities.page(params[:page])
	end

	def index
		@search = Search.order(:id).page(params[:page])
	end
end
