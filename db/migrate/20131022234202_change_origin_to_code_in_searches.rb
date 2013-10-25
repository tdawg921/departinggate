class ChangeOriginToCodeInSearches < ActiveRecord::Migration
  def up
  	change_column :searches, :origin, :text
  end

  def down
  	change_column :searches, :origin, :int
  end
end
