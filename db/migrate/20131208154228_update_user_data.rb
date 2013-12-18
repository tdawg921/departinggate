class UpdateUserData < ActiveRecord::Migration
  def up
    remove_column :user_data, :Email_Address
    remove_column :user_data, :Party_Group_ID
    remove_column :user_data, :Name_ID
    remove_column :user_data, :Home_City
    remove_column :user_data, :Home_Airport
    remove_column :user_data, :Address_ID
    remove_column :user_data, :Dest_Pref_Reg
    remove_column :user_data, :Dest_Airport_Pref
    remove_column :user_data, :Telephone_1
    remove_column :user_data, :Telephone_2
    remove_column :user_data, :Flight_Class_Pref
    remove_column :user_data, :Hotel_Bed_Pref
    remove_column :user_data, :Hotel_Smoke_Pref
    remove_column :user_data, :Hotel_Class_Pref
    remove_column :user_data, :Car_Size_Pref
      end

  def down
    add_column :user_data, :Email_Address, :string
    add_column :user_data, :Party_Group_ID, :integer
    add_column :user_data, :Name_ID, :integer
    add_column :user_data, :Home_City, :integer
    add_column :user_data, :Home_Airport, :string
    add_column :user_data, :Address_ID, :integer
    add_column :user_data, :Dest_Pref_Reg, :string
    add_column :user_data, :Dest_Airport_Pref, :string
    add_column :user_data, :Telephone_1, :string
    add_column :user_data, :Telephone_2, :string
    add_column :user_data, :Flight_Class_Pref, :string
    add_column :user_data, :Hotel_Bed_Pref, :string
    add_column :user_data, :Hotel_Smoke_Pref, :string
    add_column :user_data, :Hotel_Class_Pref, :string
    add_column :user_data, :Car_Size_Pref, :string
  end
end
