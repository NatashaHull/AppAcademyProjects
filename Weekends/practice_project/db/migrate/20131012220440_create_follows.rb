class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :followee_id
      t.integer :follower_id

      t.timestamps
    end
    add_index :follows, :followee_id
    add_index :follows, :follower_id
    add_index :follows, [:followee_id, :follower_id], :unique => true
  end
end
