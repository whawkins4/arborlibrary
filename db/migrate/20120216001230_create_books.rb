class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :accession
      t.string :date
      t.string :dewey
      t.string :cutter
      t.string :copy
      t.string :auth_last
      t.string :auth_first
      t.string :auth_middle
      t.string :title
      t.string :series
      t.string :format
      t.string :isbn
      t.string :lccn
      t.string :pub_name
      t.string :pub_place
      t.string :copyright
      t.string :illustrated
      t.string :illus_type
      t.string :pages
      t.string :subject1
      t.string :subject2
      t.string :subject3
      t.string :subject4
      t.string :notes1
      t.string :notes2
      t.string :notes3
      t.text :summary
      t.string :awards_publicity
      t.string :collection
      t.string :source

      t.timestamps
    end
  end
end
