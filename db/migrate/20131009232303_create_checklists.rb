class CreateChecklists < ActiveRecord::Migration
  def change
    create_table :checklists do |t|
      t.integer :card_id, null: false
      t.string :title, null: false, default: "Checklist"

      t.timestamps
    end

    add_index :checklists, :card_id
    rename_column :checklist_items, :card_id, :checklist_id
  end
end
