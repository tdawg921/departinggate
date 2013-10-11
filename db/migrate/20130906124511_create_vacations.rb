class CreateVacations < ActiveRecord::Migration
  def change
    create_table :vacations do |t|

      t.timestamps
    end
  end
end
