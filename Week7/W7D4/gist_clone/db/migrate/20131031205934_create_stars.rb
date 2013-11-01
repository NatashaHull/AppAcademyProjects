class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.integer :gist_id, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end

    add_index :stars, [:gist_id, :user_id], :unique => true
    add_index :stars, :gist_id
    add_index :stars, :user_id
  end
end
