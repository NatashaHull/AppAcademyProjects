class AddOwnerIdToCats < ActiveRecord::Migration
  def up
    add_column :cats, :owner_id, :integer
    add_index :cats, :owner_id
  end

  def down
    remove_column :cats, :owner_id
  end
end
