class AddUserInitials < ActiveRecord::Migration
  def change
    add_column :users, :initials, :string
  end
end
