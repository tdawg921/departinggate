class City < ActiveRecord::Base
	attr_accessor :rating
	set_table_name "ref_city"
	has_many :CityRegions

	def set_rating(rating)
		self.send("rating=", rating)
	end

	def self.city_name
		@city_name
	end

	def self.id
		@id
	end
end
