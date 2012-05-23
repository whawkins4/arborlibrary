class AddCheckoutsCopyId < ActiveRecord::Migration
  def up
    add_column :checkouts, :copy_id, :integer
    remove_column :checkouts, :book_accession_id
    remove_column :checkouts, :patron_id
    add_column :checkouts, :user_id, :integer
  end

  def down
  end
end
