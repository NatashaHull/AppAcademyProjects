class CreateCatRentals < ActiveRecord::Migration
  def change
    create_table :cat_rentals do |t|
      t.integer :cat_id, :null => false
      t.date :start_date, :null => false
      t.date :end_date, :null => false
      t.string :status, :default => "PENDING"

      t.timestamps
    end

    add_index :cat_rentals, :cat_id
  end
end
