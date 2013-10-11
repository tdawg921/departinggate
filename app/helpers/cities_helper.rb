module CitiesHelper
	def cities_chart_data(search)
		city_data = []
		search.each do |s|
			hash = { city_name: s.city_name, rating: s.rating}
			city_data.push(hash)
		end

		city_data
	end
end