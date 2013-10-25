class AddColumnToTracksLyrics < ActiveRecord::Migration
  def up
    add_column :tracks, :lyrics, :text
  end

  def down
    remove_column :tracks, :lyrics
  end
end
