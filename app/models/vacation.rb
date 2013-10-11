class Vacation < ActiveRecord::Base
	set_table_name "ref_vacation_type"
	attr_accessible :Vacaton_Type_Code, :Vacation_Type_Description
end
