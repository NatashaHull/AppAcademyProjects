class AddSessionTokenIndexToUsersTable < ActiveRecord::Migration
  def up
    add_index :users, :session_token
  end
end
