class UserData < ActiveRecord::Base
	set_table_name "user_data"

	belongs_to :user

	alias_attribute :user_id, :User_ID

	attr_accessible :user_id, :first_name, :middle_name, :last_name, :name_suffix, 
	:gender, :birthday, :home_phone, :work_phone, :mobile_phone, 
	:language_preference, :home_airport, :seat_preference, :meal_preference, 
	:special_request_preference
end