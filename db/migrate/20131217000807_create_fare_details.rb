class CreateFareDetails < ActiveRecord::Migration
  def up
  	create_table :fare_details do |t|
  		t.integer :id
  		t.belongs_to :recommendation
  		t.integer :segment_ref
  		t.string :rbd
  		t.string :cabin
  		t.string :avl_status
  		t.string :fare_basis
  		t.string :passenger_type
  		t.string :fare_type
  		t.string :breakpoint
  		t.string :booking_class_details
  	end
  end

  def down
  end
end
