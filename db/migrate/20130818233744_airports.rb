class Airports < ActiveRecord::Migration
  def up
  	change_table :ref_airport do |t|
  		#t.remove :Airport_Code, :Airport_Name_Dsc, :City_Code
  		t.string :code, :name, :city, :state, :latitude, :longitude
  		t.integer :id, :zip
  		t.index :id, :code, :name, :city
  		t.timestamps
  	end
  end

  def down
  end
end
