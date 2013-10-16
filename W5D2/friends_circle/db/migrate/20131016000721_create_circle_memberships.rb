class CreateCircleMemberships < ActiveRecord::Migration
  def change
    create_table :circle_memberships do |t|
      t.integer :circle_id, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end

    add_index :circle_memberships, [:user_id, :circle_id], :unique => true
    add_index :circle_memberships, :user_id
    add_index :circle_memberships, :circle_id
  end
end
