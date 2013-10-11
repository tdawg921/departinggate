class CreateCityRegions < ActiveRecord::Migration
  def change
    create_table :city_regions do |t|

      t.timestamps
    end
  end
end
