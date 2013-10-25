class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :body
      t.integer :track_id

      t.timestamps
    end
  end
end
