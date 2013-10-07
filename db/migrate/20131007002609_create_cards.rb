class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :title, null: false
      t.string :description
      t.datetime :start_date
      t.datetime :due_date
      t.integer :catagory_id, null: false

      t.timestamps
    end
    
    add_index :cards, :catagory_id
  end
end
