class RemoveStartDates < ActiveRecord::Migration
  def up
    remove_column :cards, :start_date
  end

  def down
    add_column :cards, :start_date, :datetime
  end
end
