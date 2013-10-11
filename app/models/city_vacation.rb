class CityVacation < ActiveRecord::Base
  # attr_accessible :title, :body
  set_table_name "city_vacation_type_xref"

  belongs_to :city
  belongs_to :vacation
end