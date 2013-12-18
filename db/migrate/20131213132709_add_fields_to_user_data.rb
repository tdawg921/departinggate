class AddFieldsToUserData < ActiveRecord::Migration
  def change
    add_column :user_data, :first_name, :string
    add_column :user_data, :middle_name, :string
    add_column :user_data, :last_name, :string
    add_column :user_data, :name_suffix, :string
    add_column :user_data, :gender, :string
    add_column :user_data, :birthday, :date
    add_column :user_data, :home_phone, :string
    add_column :user_data, :work_phone, :string
    add_column :user_data, :mobile_phone, :string
    add_column :user_data, :language_preference, :string
    add_column :user_data, :home_airport, :string
    add_column :user_data, :seat_preference, :string
    add_column :user_data, :meal_preference, :string
    add_column :user_data, :special_request_preference, :string  ##e.g. wheelchair (see orbitz)
  end
end
