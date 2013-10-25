class AddTypeColumnToTracksTable < ActiveRecord::Migration
  def up
    add_column :tracks, :track_type, :string
  end

  def down
    remove_column :tracks, :track_type
  end
end
