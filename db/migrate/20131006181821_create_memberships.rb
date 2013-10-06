class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :user_id, null: false
      t.integer :board_id, null: false
      t.boolean :admin, default: false

      t.timestamps
    end
    
    add_index :memberships, :user_id
    add_index :memberships, :board_id
    add_index :memberships, [:user_id, :board_id], unique: true
  end
end
