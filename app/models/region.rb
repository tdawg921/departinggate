class Region < ActiveRecord::Base
  set_table_name "ref_region"
  attr_accessible :id, :name

  has_many :CityRegions


  def find_cities_by_region
 	Region.where("")
  end
end
