class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.string :tag_id
      t.string :shortened_url_id

      t.timestamps
    end
  end
end
