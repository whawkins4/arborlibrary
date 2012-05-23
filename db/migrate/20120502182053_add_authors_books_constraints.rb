class AddAuthorsBooksConstraints < ActiveRecord::Migration
  def up
    add_foreign_key(:authors_books, :authors)
    add_foreign_key(:authors_books, :books)
  end

  def down
  end
end
