class AddTwitterUserIdToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :twitter_user_id, :integer
  end
end
