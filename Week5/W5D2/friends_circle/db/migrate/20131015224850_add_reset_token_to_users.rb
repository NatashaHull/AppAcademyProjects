class AddResetTokenToUsers < ActiveRecord::Migration
  def up
    add_column :users, :reset_token, :string, :unique => true
  end

  def down
    remove_column :users, :reset_token
  end
end
