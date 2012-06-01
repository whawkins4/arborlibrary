# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120516164449) do

  create_table "authors", :force => true do |t|
    t.string   "auth_last"
    t.string   "auth_first"
    t.string   "auth_middle"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authors_books", :force => true do |t|
    t.integer  "author_id"
    t.integer  "book_id"
    t.integer  "authorship_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_import", :id => false, :force => true do |t|
    t.string "timestamp",        :limit => nil
    t.string "accession",        :limit => nil
    t.string "dewey",            :limit => nil
    t.string "cutter",           :limit => nil
    t.string "copy",             :limit => nil
    t.string "title",            :limit => nil
    t.string "subtitle",         :limit => nil
    t.string "last",             :limit => nil
    t.string "first",            :limit => nil
    t.string "middle",           :limit => nil
    t.string "series",           :limit => nil
    t.string "number",           :limit => nil
    t.string "format",           :limit => nil
    t.string "isbn",             :limit => nil
    t.string "lccn",             :limit => nil
    t.string "publisher",        :limit => nil
    t.string "place",            :limit => nil
    t.string "copyright",        :limit => nil
    t.string "illustrated",      :limit => nil
    t.string "type",             :limit => nil
    t.string "pages",            :limit => nil
    t.string "contributor1",     :limit => nil
    t.string "contributor2",     :limit => nil
    t.string "contributor3",     :limit => nil
    t.string "subject1",         :limit => nil
    t.string "subject2",         :limit => nil
    t.string "subject3",         :limit => nil
    t.string "subject4",         :limit => nil
    t.string "subject5",         :limit => nil
    t.string "subject6",         :limit => nil
    t.string "subject7",         :limit => nil
    t.string "subject8",         :limit => nil
    t.string "summary",          :limit => nil
    t.string "collection",       :limit => nil
    t.string "price",            :limit => nil
    t.string "source",           :limit => nil
    t.string "awards_publicity", :limit => nil
  end

  create_table "books", :force => true do |t|
    t.string   "date"
    t.string   "title"
    t.string   "series"
    t.string   "format"
    t.string   "isbn"
    t.string   "lccn"
    t.string   "copyright"
    t.string   "illustrated"
    t.string   "illus_type"
    t.string   "pages"
    t.string   "subject1"
    t.string   "subject2"
    t.string   "subject3"
    t.string   "subject4"
    t.string   "notes1"
    t.string   "notes2"
    t.string   "notes3"
    t.text     "summary"
    t.string   "awards_publicity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "publisher_id"
    t.boolean  "deleted",          :default => false, :null => false
    t.string   "subtitle"
    t.integer  "series_number"
  end

  create_table "books_subjects", :force => true do |t|
    t.integer "subject_id"
    t.integer "book_id"
  end

  create_table "checkin_import", :id => false, :force => true do |t|
    t.string   "checkin_time",        :limit => 500
    t.string   "accession",           :limit => 500
    t.integer  "copy_id"
    t.datetime "checkin_time_casted"
  end

  create_table "checkout_import", :id => false, :force => true do |t|
    t.string "checkout_time", :limit => 500
    t.string "user_id",       :limit => 500
    t.string "accession",     :limit => 500
  end

  create_table "checkouts", :force => true do |t|
    t.datetime "checked_out_on"
    t.datetime "checked_in_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "copy_id"
    t.integer  "user_id"
    t.boolean  "deleted",        :default => false, :null => false
  end

  create_table "cleanup_books_with_dup_isbns", :id => false, :force => true do |t|
    t.string "timestamp",        :limit => nil
    t.string "accession",        :limit => nil
    t.string "dewey",            :limit => nil
    t.string "cutter",           :limit => nil
    t.string "copy",             :limit => nil
    t.string "title",            :limit => nil
    t.string "subtitle",         :limit => nil
    t.string "last",             :limit => nil
    t.string "first",            :limit => nil
    t.string "middle",           :limit => nil
    t.string "series",           :limit => nil
    t.string "number",           :limit => nil
    t.string "format",           :limit => nil
    t.string "isbn",             :limit => nil
    t.string "lccn",             :limit => nil
    t.string "publisher",        :limit => nil
    t.string "place",            :limit => nil
    t.string "copyright",        :limit => nil
    t.string "illustrated",      :limit => nil
    t.string "type",             :limit => nil
    t.string "pages",            :limit => nil
    t.string "contributor1",     :limit => nil
    t.string "contributor2",     :limit => nil
    t.string "contributor3",     :limit => nil
    t.string "subject1",         :limit => nil
    t.string "subject2",         :limit => nil
    t.string "subject3",         :limit => nil
    t.string "subject4",         :limit => nil
    t.string "subject5",         :limit => nil
    t.string "subject6",         :limit => nil
    t.string "subject7",         :limit => nil
    t.string "subject8",         :limit => nil
    t.string "summary",          :limit => nil
    t.string "collection",       :limit => nil
    t.string "price",            :limit => nil
    t.string "source",           :limit => nil
    t.string "awards_publicity", :limit => nil
  end

  create_table "copies", :force => true do |t|
    t.integer  "book_id"
    t.string   "catalog_date"
    t.string   "copy_number"
    t.string   "collection"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "accession"
    t.boolean  "deleted",                    :default => false, :null => false
    t.string   "dewey",        :limit => 10
    t.string   "cutter",       :limit => 4
  end

  add_index "copies", ["accession"], :name => "index_copies_on_accession", :unique => true

  create_table "data_tools", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holds", :force => true do |t|
    t.integer  "book_accession_id"
    t.integer  "patron_id"
    t.datetime "hold_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "library_card_map", :id => false, :force => true do |t|
    t.string "first", :limit => 500
    t.string "last",  :limit => 500
    t.string "grade", :limit => 500
    t.string "new",   :limit => 500
    t.string "old",   :limit => 500
  end

  create_table "original", :id => false, :force => true do |t|
    t.string "accession",        :limit => 500
    t.string "date",             :limit => 500
    t.string "dewey",            :limit => 500
    t.string "cutter",           :limit => 500
    t.string "copy",             :limit => 500
    t.string "auth_last",        :limit => 500
    t.string "auth_first",       :limit => 500
    t.string "auth_middle",      :limit => 500
    t.string "title",            :limit => 500
    t.string "series",           :limit => 500
    t.string "format",           :limit => 500
    t.string "isbn",             :limit => 500
    t.string "lccn",             :limit => 500
    t.string "pub_name",         :limit => 500
    t.string "pub_place",        :limit => 500
    t.string "copyright",        :limit => 500
    t.string "illustrated",      :limit => 500
    t.string "illus_type",       :limit => 500
    t.string "pages",            :limit => 500
    t.string "subject1",         :limit => 500
    t.string "subject2",         :limit => 500
    t.string "subject3",         :limit => 500
    t.string "subject4",         :limit => 500
    t.string "notes1",           :limit => 500
    t.string "notes2",           :limit => 500
    t.string "notes3",           :limit => 500
    t.string "summary",          :limit => 500
    t.string "awards_publicity", :limit => 500
    t.string "collection",       :limit => 500
    t.string "source",           :limit => 500
  end

  create_table "patrons", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "grade"
    t.string   "library_card"
  end

  create_table "pg_search_documents", :force => true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publishers", :force => true do |t|
    t.string   "pub_name"
    t.string   "pub_place"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", :force => true do |t|
    t.string  "subject",   :null => false
    t.integer "parent_id"
  end

  create_table "users", :force => true do |t|
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_type"
    t.string   "grade"
    t.string   "library_card"
    t.boolean  "deleted",         :default => false, :null => false
    t.string   "first"
    t.string   "last"
  end

  create_table "users_import_temp", :id => false, :force => true do |t|
    t.string "name",         :limit => nil
    t.string "library_card", :limit => nil
    t.string "grade",        :limit => nil
  end

  add_foreign_key "authors_books", "authors", :name => "authors_books_author_id_fk"
  add_foreign_key "authors_books", "books", :name => "authors_books_book_id_fk"

  add_foreign_key "books", "publishers", :name => "books_publisher_id_fk"

  add_foreign_key "books_subjects", "books", :name => "books_subjects_book_id_fk"
  add_foreign_key "books_subjects", "subjects", :name => "books_subjects_subject_id_fk"

  add_foreign_key "checkouts", "copies", :name => "checkouts_copy_id_fk"
  add_foreign_key "checkouts", "users", :name => "checkouts_user_id_fk"

  add_foreign_key "copies", "books", :name => "copies_book_id_fk"

end
