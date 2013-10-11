class CreateCityVacations < ActiveRecord::Migration
  def change
    create_table :city_vacations do |t|

      t.timestamps
    end
  end
end
