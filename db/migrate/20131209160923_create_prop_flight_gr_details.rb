class CreatePropFlightGrDetails < ActiveRecord::Migration
  def up
  	create_table :prop_flight_gr_details do |t|
    	t.integer :id
    	t.belongs_to :group_of_flights
    	t.string :ref
    	t.string :unit_qualifier
    	t.timestamps
    end
  end

  def down
  end
end
