class CreateRecommendations < ActiveRecord::Migration
  def up
  	    create_table :recommendations do |t|
    	t.integer :id
    	t.belongs_to :search
    	t.integer :item_number_id
    	t.string :fare
    	t.string :taxes
    	t.string :transport_stage_qualifier
    	t.string :company
    	t.string 
    	t.timestamps
    end
  end

  def down
  end
end
