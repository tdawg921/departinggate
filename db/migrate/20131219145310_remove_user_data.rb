class RemoveUserData < ActiveRecord::Migration
  def up
  	drop_table :user_data
  end

  def down
  end
end
