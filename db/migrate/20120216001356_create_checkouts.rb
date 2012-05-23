class CreateCheckouts < ActiveRecord::Migration
  def change
    create_table :checkouts do |t|
      t.integer :book_accession_id
      t.integer :patron_id
      t.timestamp :checked_out_on
      t.timestamp :checked_in_on

      t.timestamps
    end
  end
end
