class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :topic

      t.timestamps
    end
  end
end
