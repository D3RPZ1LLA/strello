class CreateCatagories < ActiveRecord::Migration
  def change
    create_table :catagories do |t|
      t.string :title
      t.integer :board_id

      t.timestamps
    end
    
    add_index :catagories, :board_id
    add_index :catagories, [:title, :board_id], unique: true
  end
end
