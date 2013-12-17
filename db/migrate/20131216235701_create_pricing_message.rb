class CreatePricingMessage < ActiveRecord::Migration
  def up
  	create_table :pricing_message do |t|
  		t.integer :id
  		t.belongs_to :recommendation_id
  		t.string :text_subject_qualifier
  		t.string :information_type
  		t.string :description
  	end
  end

  def down
  end
end
