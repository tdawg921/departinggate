class City < ActiveRecord::Base
	attr_accessor :rating, :airport
	set_table_name "ref_city"
	has_many :CityRegions

	def set_rating(rating)
		self.send("rating=", rating)
	end

	def get_best_airport(id)
		@id = id
		airport = 
		self.send("airport=", )
	end

	def self.city_name
		@city_name
	end

	def self.id
		@id
	end

	def airports
		we
	end
end
