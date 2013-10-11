class CityRegion < ActiveRecord::Base
  #attr_accessible :ref_city_id, :ref_region_id
  #attr_reader :ref_city_id, :ref_region_id
  set_table_name "ref_city_region"

  belongs_to :city
  belongs_to :region

 end
