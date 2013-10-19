class AddBoolsToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :flight, :boolean
    add_column :searches, :hotel, :boolean
    add_column :searches, :car, :boolean
  end
end
