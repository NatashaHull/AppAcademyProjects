class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :owner_id
      t.string :url
      t.string :title

      t.timestamps
    end
    add_index :photos, :owner_id
    add_index :photos, :title
  end
end
