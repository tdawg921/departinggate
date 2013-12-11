class FlightDetails < ActiveRecord::Base
  attr_accessible :id, :group_of_flights_id, :date_of_departure, :time_of_departure,
    :date_of_arrival, :time_of_arrival, :dep_location_id, :dep_terminal, :arr_location_id,
    :arr_terminal, :marketing_carrier, :operating_carrier, :flight_number, :equipment_type, 
    :electronic_ticketing, :product_detail_qualifier
  belongs_to :group_of_flights

end
