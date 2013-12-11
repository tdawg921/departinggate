class PropFlightGrDetails < ActiveRecord::Base
  attr_accessible :id, :group_of_flights_id, :ref, :unit_qualifier
  belongs_to :group_of_flights

  def group_of_flights_id
  	@group_of_flights_id
  end

  def ref
  	@ref
  end

  def unit_qualifier
  	@unit_qualifier
  end

end
