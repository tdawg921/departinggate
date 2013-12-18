class Recommendations < ActiveRecord::Base
  attr_accessible :id

  def self.id
  	@id
  end
    
end
