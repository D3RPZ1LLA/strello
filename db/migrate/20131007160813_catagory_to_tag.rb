class CatagoryToTag < ActiveRecord::Migration
  def change
    rename_column :cards, :catagory_id, :board_id
  end
end
