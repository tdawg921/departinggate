# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131217000807) do

  create_table "address", :primary_key => "Address_ID", :force => true do |t|
    t.string  "Street_1", :limit => 100
    t.string  "Street_2", :limit => 100
    t.string  "City",     :limit => 45
    t.string  "State",    :limit => 2
    t.integer "Zip_Code"
    t.string  "Country",  :limit => 45
  end

  create_table "airports", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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

  create_table "cities", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "city_regions", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "city_vacation_type_xref", :primary_key => "ID", :force => true do |t|
    t.integer "City_Code",     :null => false
    t.integer "Vacation_Type", :null => false
    t.integer "rating"
  end

  add_index "city_vacation_type_xref", ["City_Code"], :name => "fk_city_idx"
  add_index "city_vacation_type_xref", ["Vacation_Type"], :name => "fk_type_idx"

  create_table "city_vacations", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "fare_details", :force => true do |t|
    t.integer "recommendation_id"
    t.integer "segment_ref"
    t.string  "rbd"
    t.string  "cabin"
    t.string  "avl_status"
    t.string  "fare_basis"
    t.string  "passenger_type"
    t.string  "fare_type"
    t.string  "breakpoint"
    t.string  "booking_class_details"
  end

  create_table "flight_details", :force => true do |t|
    t.integer  "group_of_flights_id"
    t.date     "date_of_departure"
    t.string   "time_of_departure"
    t.date     "date_of_arrival"
    t.string   "time_of_arrival"
    t.string   "dep_location_id"
    t.string   "dep_terminal"
    t.string   "arr_location_id"
    t.string   "arr_terminal"
    t.string   "marketing_carrier"
    t.string   "operating_carrier"
    t.string   "flight_number"
    t.string   "equipment_type"
    t.string   "electronic_ticketing"
    t.string   "product_detail_qualifier"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "flight_recommendations", :force => true do |t|
    t.integer "recommendation_id"
    t.integer "flight_details_id_out"
    t.integer "flight_details_id_in"
  end

  create_table "group_of_flights", :force => true do |t|
    t.integer  "search_id"
    t.integer  "flight_proposal"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "master_pricer_searches", :force => true do |t|
    t.integer  "search_id"
    t.binary   "xml",        :limit => 2147483647
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

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

  create_table "pricing_message", :force => true do |t|
    t.integer "recommendation_id_id"
    t.string  "text_subject_qualifier"
    t.string  "information_type"
    t.string  "description"
  end

  create_table "prop_flight_gr_details", :force => true do |t|
    t.integer  "group_of_flights_id"
    t.string   "ref"
    t.string   "unit_qualifier"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "recommendations", :force => true do |t|
    t.integer  "search_id"
    t.integer  "item_number_id"
    t.string   "fare"
    t.string   "taxes"
    t.string   "transport_stage_qualifier"
    t.string   "company"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "ref_airport", :force => true do |t|
    t.string  "name",      :null => false
    t.string  "code"
    t.string  "latitude"
    t.string  "longitude"
    t.string  "city"
    t.string  "state"
    t.integer "zip"
  end

  add_index "ref_airport", ["id"], :name => "id_UNIQUE", :unique => true

  create_table "ref_city", :force => true do |t|
    t.string "city_name"
    t.string "state"
    t.string "city_state"
  end

  create_table "ref_city_airport", :force => true do |t|
    t.integer  "city_id"
    t.string   "airport_code"
    t.string   "primary",      :limit => 45
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "ref_city_region", :force => true do |t|
    t.integer "ref_city_id"
    t.integer "ref_region_id"
    t.integer "rating"
  end

  add_index "ref_city_region", ["ref_city_id"], :name => "fk_city_idx"
  add_index "ref_city_region", ["ref_region_id"], :name => "fk_region_idx"

  create_table "ref_region", :primary_key => "Region_Code", :force => true do |t|
    t.string "Region_Description", :limit => 45, :null => false
  end

  create_table "ref_vacation_type", :primary_key => "Vacaton_Type_Code", :force => true do |t|
    t.string "Vacation_Type_Description", :limit => 45
  end

  create_table "regions", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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

  create_table "searches", :force => true do |t|
    t.integer  "region_id"
    t.integer  "vacation_id"
    t.string   "destination"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "budget"
    t.date     "depart_date"
    t.date     "return_date"
    t.text     "origin"
    t.integer  "traveller"
    t.boolean  "flight"
    t.boolean  "hotel"
    t.boolean  "car"
  end

  create_table "session_user_xref", :primary_key => "Session_ID", :force => true do |t|
    t.integer "User_ID", :null => false
  end

  add_index "session_user_xref", ["User_ID"], :name => "Session_ID_Xref_User_ID_idx"

  create_table "soap_sessions", :force => true do |t|
    t.string   "session_id"
    t.string   "security_token"
    t.string   "timestamps"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

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

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "vacations", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
