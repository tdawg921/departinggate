class AddBudgetDatesOriginTravellerToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :budget, :string
    add_column :searches, :depart_date, :date
    add_column :searches, :return_date, :date
    add_column :searches, :origin, :int
    add_column :searches, :traveller, :int
  end
end
