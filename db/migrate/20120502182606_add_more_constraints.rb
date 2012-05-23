class AddMoreConstraints < ActiveRecord::Migration
  def up
    add_foreign_key(:books_subjects, :books)
    add_foreign_key(:books_subjects, :subjects)
    add_foreign_key(:books, :publishers)
    add_foreign_key(:copies, :books)
    add_foreign_key(:checkouts, :copies)
    add_foreign_key(:checkouts, :users)    
  end

  def down
  end
end
