class CreateGroupOfFlights < ActiveRecord::Migration
  def up
	create_table :group_of_flights do |t|
		t.integer :id
		t.belongs_to :search
		t.integer :flight_proposal
		t.timestamps
	end
  end

  def down
  end
end
