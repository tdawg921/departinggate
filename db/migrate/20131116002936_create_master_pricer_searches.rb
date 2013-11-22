class CreateMasterPricerSearches < ActiveRecord::Migration
  def change
    create_table :master_pricer_searches do |t|
    	t.integer :id
    	t.belongs_to :search
    	t.string :xml
    	t.timestamps
    end
  end
end
