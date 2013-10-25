class CreateCheers < ActiveRecord::Migration
  def change
    create_table :cheers do |t|
      t.integer :goal_id, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end

    add_index :cheers, :goal_id
    add_index :cheers, :user_id
    add_index :cheers, [:goal_id, :user_id], :unique => true
  end
end
