class CreateFlightRecommendations < ActiveRecord::Migration
  def up
  	create_table :flight_recommendations do |t|
  		t.integer :id
  		t.integer :recommendation_id
  		t.integer :flight_details_id_out
  		t.integer :flight_details_id_in
  	end
  end

  def down
  end
end
