class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :twitter_follower_id, :null => false
      t.integer :twitter_followee_id, :null => false

      t.timestamps
    end

    add_index :follows, :twitter_follower_id
    add_index :follows, :twitter_followee_id
    add_index :follows, [:twitter_followee_id, :twitter_follower_id], :unique => true
  end
end
