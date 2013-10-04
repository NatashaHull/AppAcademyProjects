class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :instructor
      t.integer :prereq_id

      t.timestamps
    end
  end
end
