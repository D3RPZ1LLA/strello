class AddIndexToSortings < ActiveRecord::Migration
  def change
    add_column :catagories, :sort_idx, :integer
    add_column :cards, :sort_idx, :integer
  end
end
