class AirportsController < ApplicationController
	def index
		@airports = Airport.find(:all)
		respond_to do |format|
			format.json {render json: @airports.as_json(only: [:code], methods: [:tokens, :value])}
		end
	end
end