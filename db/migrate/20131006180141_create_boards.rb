class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :title, null: false
      t.integer :creator_id, null: false

      t.timestamps
    end
    
    add_index :boards, :creator_id
  end
end
