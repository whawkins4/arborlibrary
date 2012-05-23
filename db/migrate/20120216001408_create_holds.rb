class CreateHolds < ActiveRecord::Migration
  def change
    create_table :holds do |t|
      t.integer :book_accession_id
      t.integer :patron_id
      t.timestamp :hold_date

      t.timestamps
    end
  end
end
