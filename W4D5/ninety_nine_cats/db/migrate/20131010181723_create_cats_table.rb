class CreateCatsTable < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :name, :null => false
      t.integer :age, :null => false
      t.date :birth_date, :null => false
      t.string :gender, :null => false
      t.string :color, :null => false
      t.timestamps
    end
  end
end
