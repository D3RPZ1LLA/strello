class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :card_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
    
    add_index :participations, :card_id
    add_index :participations, :user_id
    add_index :participations, [:card_id, :user_id], unique: true
  end
end
