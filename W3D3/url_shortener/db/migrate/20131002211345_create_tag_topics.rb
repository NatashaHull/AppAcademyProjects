class CreateTagTopics < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.string :tag_name

      t.timestamps
    end
    add_index :tag_topics, :tag_name
  end
end
