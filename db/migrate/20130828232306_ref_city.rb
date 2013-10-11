class RefCity < ActiveRecord::Migration
  def up
  	create_table :ref_city do |t|
  		t.string :city_name, :state, :city_state
  	end
  end

  def down

  end
end
