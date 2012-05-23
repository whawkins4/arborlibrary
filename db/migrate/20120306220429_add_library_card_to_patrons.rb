class AddLibraryCardToPatrons < ActiveRecord::Migration
  def change
    add_column :patrons, :library_card, :string
  end
end
