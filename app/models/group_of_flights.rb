class GroupOfFlights < ActiveRecord::Base
  attr_accessible :search_id, :flight_proposal
  belongs_to :searches
  
  def self.id
  	@id
  end


end
