class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :name
      t.integer :moderator_id

      t.timestamps
    end

    add_index :subs, :name, :unique => true
    add_index :subs, :moderator_id
  end
end
