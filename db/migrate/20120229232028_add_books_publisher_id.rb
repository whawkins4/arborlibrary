class AddBooksPublisherId < ActiveRecord::Migration
  def up
      add_column :books, :publisher_id, :integer
  end

  def down
  end
end
