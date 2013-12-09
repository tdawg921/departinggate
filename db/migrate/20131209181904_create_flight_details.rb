class CreateFlightDetails < ActiveRecord::Migration
  def up
    create_table :flight_details do |t|
    	t.integer :id
    	t.belongs_to :group_of_flights
    	t.date :date_of_departure
    	t.string :time_of_departure
    	t.date :date_of_arrival
    	t.string :time_of_arrival
    	t.string :dep_location_id
    	t.string :dep_terminal
    	t.string :arr_location_id
    	t.string :arr_terminal
    	t.string :marketing_carrier
    	t.string :operating_carrier
    	t.string :flight_number
    	t.string :equipment_type
    	t.string :electronic_ticketing
    	t.string :product_detail_qualifier
    	t.timestamps
    end
  end

  def down
  end
end
