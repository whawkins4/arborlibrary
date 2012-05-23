class CreateAuthorsBooks < ActiveRecord::Migration
  def up
    create_table :authors_books do |t|
      t.integer :author_id
      t.integer :book_id
      t.integer :authorship_type
      t.timestamps
    end
  end

  def down
  end
end
