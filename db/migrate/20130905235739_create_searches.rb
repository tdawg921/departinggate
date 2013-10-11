class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.integer :region_id
      t.integer :vacation_id
      t.string :destination

      t.timestamps
    end
  end
end
