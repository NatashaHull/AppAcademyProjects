class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.integer :user_id, :null => false
      t.string :name, :null => false

      t.timestamps
    end

    add_index :circles, [:user_id, :name], :unique => true
    add_index :circles, :user_id
    add_index :circles, :name
  end
end
