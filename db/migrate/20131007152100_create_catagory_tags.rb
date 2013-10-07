class CreateCatagoryTags < ActiveRecord::Migration
  def change
    create_table :catagory_tags do |t|
      t.integer :card_id
      t.integer :catagory_id

      t.timestamps
    end
  end
end
