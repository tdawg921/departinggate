class CreateUserProfile < ActiveRecord::Migration
	def change
		create_table :user_profile do |t|
			t.belongs_to :user
			t.string :first_name
			t.string :middle_name
			t.string :last_name
			t.string :name_suffix
			t.string :gender
			t.date :birthday
			t.string :home_phone
			t.string :work_phone
			t.string :mobile_phone
			t.string :language_preference
			t.string :home_airport
			t.string :seat_preference
			t.string :meal_preference
    		t.string :special_request_preference  ##e.g. wheelchair (see orbitz)
		end
	end
end
