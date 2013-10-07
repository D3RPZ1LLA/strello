class CreateChecklistItems < ActiveRecord::Migration
  def change
    create_table :checklist_items do |t|
      t.string :title, null: false
      t.integer :card_id, null: false

      t.timestamps
    end
    
    add_index :checklist_items, :card_id
  end
end
