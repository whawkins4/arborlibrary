class AddBookSubtitle < ActiveRecord::Migration
  def up
    add_column 'books', 'subtitle','string'
    add_column 'books', 'series_number','integer'
  end

  def down
    
  end
end
