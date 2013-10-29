class CreatePhotoTaggings < ActiveRecord::Migration
  def change
    create_table :photo_taggings do |t|
      t.integer :user_id
      t.integer :photo_id
      t.integer :x_pos
      t.integer :y_pos

      t.timestamps
    end
    add_index :photo_taggings, :user_id
    add_index :photo_taggings, :photo_id
    add_index :photo_taggings, [:x_pos, :y_pos]
  end
end
