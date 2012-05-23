class Copy < ActiveRecord::Base
  belongs_to :book
  has_many :checkouts, :order => 'checked_out_on DESC'
  validates :accession, :length => { :is => 8 },:uniqueness=>true, :presence=>true
  validates :book_id, :presence => true
  def available?
    return true if checkouts.length == 0
    return !checkouts[0].checked_in_on.nil?
  end
  def logical_delete
    self.deleted=true
    self.save    
  end
  def title
     book.title
  end
  def self.search(phrase)
      books = Book.search(phrase)
      return [] if books.length == 0
      book_ids = books.map {|book| book.id }
      copies = Copy.find(:all, :conditions=>"deleted=false and deaccessioned = false and book_id in (#{book_ids.join(',')})",:include=>:book)
      copies.sort {|a,b| a.book.title<=>b.book.title }
  end
end
