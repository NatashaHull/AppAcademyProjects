class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :friended_id, :null => false
      t.integer :friender_id, :null => false

      t.timestamps
    end

    add_index :friends, [:friender_id, :friended_id], :unique => true
    add_index :friends, :friender_id
    add_index :friends, :friended_id
  end
end
