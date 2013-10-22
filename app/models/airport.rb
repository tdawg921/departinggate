class Airport < ActiveRecord::Base
  # attr_accessible :title, :body
  set_table_name "ref_airport"
  reverse_geocoded_by :latitude, :longitude

  def value
  	value = self.code + " - " + self.name
  end

  def tokens
  	tokens = self.name.split(' ')
  end

  def self.code
  	@code
  end

  def self.name
  	@name
  end
end
