class CreateSessionTokens < ActiveRecord::Migration
  def change
    create_table :session_tokens do |t|
      t.string :session_token, :null =>false
      t.string :device, :null =>false
      t.string :ip, :null => false
      t.integer :user_id, :null =>false

      t.timestamps
    end

    add_index :session_tokens, :user_id
  end
end
