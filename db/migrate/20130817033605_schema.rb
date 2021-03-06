class Schema < ActiveRecord::Migration
  def up
  	ActiveRecord::Schema.define(:version => 0) do

  create_table "address", :primary_key => "Address_ID", :force => true do |t|
    t.string  "Street_1", :limit => 100
    t.string  "Street_2", :limit => 100
    t.string  "City",     :limit => 45
    t.string  "State",    :limit => 2
    t.integer "Zip_Code"
    t.string  "Country",  :limit => 45
  end

  create_table "booked_trip", :primary_key => "Booked_trip_ID", :force => true do |t|
    t.integer  "session_ID"
    t.integer  "User_ID"
    t.integer  "Party_Group_ID"
    t.integer  "Party_Size"
    t.string   "AIR_Departing_City",              :limit => 45
    t.string   "Air_Return_City",                 :limit => 45
    t.string   "Air_Deaparting_Airline",          :limit => 45
    t.string   "Air_Returning_Airline",           :limit => 45
    t.datetime "Air_Airline_Depart_DateTime"
    t.datetime "Air_Airline_Return_Datetime"
    t.integer  "Air_Segments_Departing_CT"
    t.integer  "Air_Segments_Return_CT"
    t.string   "Air_Seat_Class",                  :limit => 45
    t.string   "Air_Miles_travelled",             :limit => 45
    t.time     "Air_total_Travel_time_Departing"
    t.time     "Air_total_travel_time_return"
    t.decimal  "Air_Cost",                                      :precision => 5, :scale => 2
    t.string   "Hotel_ID",                        :limit => 45
    t.date     "Hotel_Checkin_Date"
    t.date     "Hotel_checkout_Date"
    t.integer  "Hotel_Room_CT"
    t.decimal  "Hotel_Room_Cost",                               :precision => 5, :scale => 2
    t.string   "Car_Agency",                      :limit => 45
    t.string   "Car_Size",                        :limit => 45
    t.date     "Car_Rental_date"
    t.integer  "Car_rental_day_ct"
    t.date     "Date Purchased"
  end

  add_index "booked_trip", ["Party_Group_ID"], :name => "Booked_Part_ID_idx"
  add_index "booked_trip", ["User_ID"], :name => "Booked_USER_ID_idx"
  add_index "booked_trip", ["session_ID"], :name => "Booked_Session_ID_idx"

  create_table "city_vacation_type_xref", :primary_key => "ID", :force => true do |t|
    t.string "City_Code",     :limit => 10, :null => false
    t.string "Vacation_Type", :limit => 45, :null => false
  end

  add_index "city_vacation_type_xref", ["Vacation_Type"], :name => "FK_Vacation_Code_idx"

  create_table "name_demographic", :primary_key => "Name_ID", :force => true do |t|
    t.integer "User_ID"
    t.integer "Party_Group_id"
    t.string  "First_Name",     :limit => 45, :null => false
    t.string  "Middle_Initial", :limit => 2
    t.string  "Last_Name",      :limit => 45, :null => false
    t.date    "DOB"
    t.string  "Gender",         :limit => 1
  end

  add_index "name_demographic", ["Party_Group_id"], :name => "fk_Name_Demographic_Pty_grp_ID_idx"

  create_table "party_group", :primary_key => "Party_Group_ID", :force => true do |t|
    t.integer "User_ID"
    t.integer "Name_ID"
  end

  create_table "ref_airport", :primary_key => "Airport_Code", :force => true do |t|
    t.string "Airport_Name_Dsc",               :null => false
    t.string "City_Code",        :limit => 45
  end

  add_index "ref_airport", ["Airport_Code"], :name => "Airport_Code_UNIQUE", :unique => true
  add_index "ref_airport", ["City_Code"], :name => "FK_City_Code_idx"

  create_table "ref_city_region", :primary_key => "City_Code", :force => true do |t|
    t.string "City",                  :limit => 100, :null => false
    t.string "State",                 :limit => 2,   :null => false
    t.string "Country",               :limit => 45,  :null => false
    t.string "Region_Code_Primary",   :limit => 10,  :null => false
    t.string "Region_Code_Secondary", :limit => 45
  end

  add_index "ref_city_region", ["Region_Code_Primary"], :name => "FK_Region_Primary_idx"

  create_table "ref_region", :primary_key => "Region_Code", :force => true do |t|
    t.string "Region_Description", :limit => 45, :null => false
  end

  create_table "ref_vacation_type", :primary_key => "Vacaton_Type_Code", :force => true do |t|
    t.string "Vacation_Type_Description", :limit => 45
  end

  create_table "search_input_data", :primary_key => "Search_Result_ID", :force => true do |t|
    t.string "Region_Selected",   :limit => 45
    t.string "Vaction_Type",      :limit => 45
    t.string "Air_Departure_LOC", :limit => 45
    t.string "Air_Arrival_LOC",   :limit => 45
    t.string "Air_Ticket_Class",  :limit => 45
    t.string "Hotel_Class",       :limit => 45
    t.string "Hotel_Nights",      :limit => 45
  end

  add_index "search_input_data", ["Air_Arrival_LOC"], :name => "FK_Air_Dest_Loc_idx"
  add_index "search_input_data", ["Air_Departure_LOC"], :name => "FK_Air_Depart_Loc_idx"
  add_index "search_input_data", ["Region_Selected"], :name => "FK_Seach_Input_Region_idx"
  add_index "search_input_data", ["Vaction_Type"], :name => "FK_Search_Input_Vaca_Type_idx"

  create_table "search_results_data_normalized", :primary_key => "Search_Results_ID", :force => true do |t|
    t.string "AIR_Departing_City",     :limit => 45
    t.string "Air_Return_City",        :limit => 45
    t.string "Air_Airline_Depart",     :limit => 45
    t.string "Air_Airline_Return",     :limit => 45
    t.string "Air_Segments_Departing", :limit => 45
    t.string "Air_Segments_Return",    :limit => 45
    t.string "Air_Miles_travelled",    :limit => 45
    t.string "Air_Travel_Time_Depart", :limit => 45
    t.string "Air_Travel_time_Return", :limit => 45
    t.string "Hotel_ID",               :limit => 45
    t.string "Car_Agency",             :limit => 45
    t.string "Car_Size",               :limit => 45
  end

  create_table "search_session_results", :id => false, :force => true do |t|
    t.integer  "Session_ID",                                                   :null => false
    t.integer  "Search_ID",                                                    :null => false
    t.datetime "DateTime_Searched",                                            :null => false
    t.string   "Result_Selected",   :limit => 1
    t.string   "Result_Booked",     :limit => 1
    t.datetime "Date_Booked"
    t.string   "Air_Modified",      :limit => 1
    t.string   "Car_Modified",      :limit => 1
    t.string   "Hotel_Modified",    :limit => 1
    t.date     "Departure_Date"
    t.date     "Return_Date"
    t.decimal  "Air_Cost",                       :precision => 9, :scale => 2
    t.decimal  "Hotel_Cost",                     :precision => 9, :scale => 2
    t.integer  "Hotel Night_Count"
    t.decimal  "Car_Cost",                       :precision => 9, :scale => 2
  end

  add_index "search_session_results", ["Search_ID"], :name => "Session_Search_idx"

  create_table "session_user_xref", :primary_key => "Session_ID", :force => true do |t|
    t.integer "User_ID", :null => false
  end

  add_index "session_user_xref", ["User_ID"], :name => "Session_ID_Xref_User_ID_idx"

  create_table "user_data", :primary_key => "User_ID", :force => true do |t|
    t.integer "Party_Group_ID"
    t.integer "Name_ID",                         :null => false
    t.string  "Email_Address",     :limit => 45, :null => false
    t.integer "Home_City"
    t.string  "Home_Airport",      :limit => 5
    t.integer "Address_ID"
    t.string  "Dest_Pref_Reg",     :limit => 45
    t.string  "Dest_Airport_Pref", :limit => 5
    t.string  "Telephone_1",       :limit => 45
    t.string  "Telephone_2",       :limit => 45
    t.string  "Flight_Class_Pref", :limit => 45
    t.string  "Hotel_Bed_Pref",    :limit => 45
    t.string  "Hotel_Smoke_Pref",  :limit => 1
    t.string  "Hotel_Class_Pref",  :limit => 45
    t.string  "Car_Size_Pref",     :limit => 2
  end

  add_index "user_data", ["Dest_Airport_Pref"], :name => "fk_Dest_Airport_Pref_idx"
  add_index "user_data", ["Home_Airport"], :name => "fk_Home_airport_idx"
  add_index "user_data", ["Name_ID"], :name => "fk_Name_ID_idx"
  add_index "user_data", ["Party_Group_ID"], :name => "fk_User_data_Party_Group_ID_idx"

end
  end

  def down
  end
end
