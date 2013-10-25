class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :text, :null => false
      t.integer :poll_id, :null => false

      t.timestamps
    end

    add_index :questions, :poll_id
  end
end
