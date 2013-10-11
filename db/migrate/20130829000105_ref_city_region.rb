class RefCityRegion < ActiveRecord::Migration
  def up
  	drop_table :ref_city_region do |t|
  	end

  	create_table :ref_city_region do |t|
  		t.references :ref_city, :ref_region
  		t.integer :rating
  	end
  end

  def down
  end
end
