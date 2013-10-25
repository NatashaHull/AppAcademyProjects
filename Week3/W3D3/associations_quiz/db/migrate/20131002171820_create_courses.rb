class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :instructor_id
      t.string :name
      t.integer :prerequisite_id

      t.timestamps
    end
  end
end
