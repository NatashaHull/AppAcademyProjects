class AddRecordingTypeToAlbums < ActiveRecord::Migration
  def up
    add_column :albums, :recording_type, :string
  end

  def down
    remove_column :albums, :recording_type
  end
end
