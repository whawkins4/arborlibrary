class CreatePatrons < ActiveRecord::Migration
  def change
    create_table :patrons do |t|
      t.string :patron_last
      t.string :patron_first
      t.string :patron_class
      t.string :patron_grade

      t.timestamps
    end
  end
end
