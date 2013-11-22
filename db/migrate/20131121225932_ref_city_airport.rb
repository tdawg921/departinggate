class RefCityAirport < ActiveRecord::Migration
  def change
    create_table :ref_city_airport do |t|
    	t.integer :id
    	t.belongs_to :city
    	t.string :airport_code
    	t.string :primary
    	t.timestamps
    end
  end
end
