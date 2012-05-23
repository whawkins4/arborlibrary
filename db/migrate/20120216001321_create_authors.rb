class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :auth_last
      t.string :auth_first
      t.string :auth_middle

      t.timestamps
    end
  end
end
