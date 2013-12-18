class FareDetail < ActiveRecord::Base
  attr_accessible :id, :recommendation_id, :segment_ref, :rbd, :cabin, :avl_status, :fare_basis, 
  	:passenger_type, :fare_type, :breakpoint, :booking_class_details

  def self.id
  	@id
  end
    
end
