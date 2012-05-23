class Book < ActiveRecord::Base
  #we don't want :depenent=>:destroy at this point because we want the book deletion to fail if there are still copies  
  has_many :copies,  :conditions => ['deleted=false and deaccessioned=false'],:order=>:copy_number  
  has_many :deaccessioned_copies, :class_name=>'Copy', :conditions=>['deleted=false and deaccessioned=true'],:order=>:copy_number
  belongs_to :publisher
  has_and_belongs_to_many :subjects
  has_many :authorships, :dependent=>:destroy
  has_many :authors, :through=>:authorships
  validates_presence_of :title
  
#  used to make more search-friendly url's--> see also find_by_accession(params[:id]) in books_controller.rb
#  def to_param
#    "#{isbn || id}"
#  end
  def self.find_by_accession(accession_id)
    copy = Copy.find_by_accession(accession_id)
    
    return copy ? copy.book : nil
  end
  def self.search(phrase) 
    phrase.gsub!(/[^a-zA-Z0-9\s]+/,'')
    sql = "select b1.id from books b1 where regexp_replace(b1.title, '[^a-zA-Z0-9\s]','') ilike '%" + phrase + "%' or regexp_replace(b1.series, '[^a-zA-Z0-9]','') ilike '%" + phrase + "%' or regexp_replace(b1.subtitle, '[^a-zA-Z0-9]','') ilike  '%" + phrase + "%' or regexp_replace(b1.summary, '[^a-zA-Z0-9]','') ilike  '%" + phrase + "%'
    union 
    select b2.id from books b2 join authors_books ab on b2.id = ab.book_id join authors a on ab.author_id = a.id
    where a.auth_first ilike '%" + phrase + "%' or a.auth_last ilike '%" + phrase + "%'
    union
    select b3.id from books b3 join books_subjects bs on b3.id = bs.book_id join subjects s on bs.subject_id = s.id
    where s.subject ilike '%" + phrase + "%'
    union
    select b4.id from books b4 join copies c on b4.id = c.book_id  
    where b4.isbn = '" + phrase + "' or cast(c.accession as character varying(8)) ='" + phrase + "' or regexp_replace(c.dewey, '[^a-zA-Z0-9\s]','') ilike '%" + phrase + "%'
    union
    select b5.id from books b5 where regexp_replace(b5.notes1, '[^a-zA-Z0-9\s]','') ilike '%" + phrase + "%' or regexp_replace(b5.notes2, '[^a-zA-Z0-9\s]','') ilike '%" + phrase + "%' or regexp_replace(b5.notes3, '[^a-zA-Z0-9\s]','') ilike '%" + phrase + "%'
    "
    
    Book.find_by_sql(sql)
  end

  def self.merge_by_isbn(isbn)
    all = Book.find_all_by_isbn(isbn)
    
    winner = all[0]
    
    all.each {|book| 
      if book.id != winner.id
        #make sure the titles match except we won't worry about final periods
        if scrub_name_premerge(book.title) == scrub_name_premerge(winner.title) 
          Book.merge(winner, book)
        else 
          puts "TITLE MISMATCH ERROR! ISBN=#{isbn} "
          puts "#{winner.title} #{winner.id}"
          puts "#{book.title} #{book.id}"          
        end
      end
      }
  end
  def self.merge(winnerBook, loserBook)
    puts "about to merge #{loserBook.id} #{loserBook.title} #{loserBook.accession} into winner #{winnerBook.id} #{winnerBook.title}"
    loserBook.copies.each {|copy| copy.book = winnerBook
      copy.save!
      puts "copy #{copy.accession} now belongs to book id #{copy.book.id}"  
      }
      loserBook.destroy

  end
  def self.merge_by_id(id_winner, id_loser)
    winner = Book.find(id_winner)
    loser = Book.find(id_loser)
    
    self.merge(winner,loser)
      
  end
  def self.dangerous_merge_all()
    sql ="select isbn from books where length(coalesce(isbn,''))>0  group by isbn having count(*) > 1"
    isbns = ActiveRecord::Base.connection.execute(sql)
    
    isbns.each {|row|
      isbn = row['isbn']
      if !isbn.blank?
        Book.merge_by_isbn(isbn)
      end
      
      }
  end
  def self.with_old_notes
    #legacy data had columns notes1,notes2, and notes3 which mostly held data that can go in our books_authors tables or other places    
    sql= "select * from books where (notes1 is not null and length(trim(notes1))>0 ) or (notes2 is not null and length(trim(notes2))>0 ) or (notes3 is not null and length(trim(notes3))>0 ) order by title limit 50 "
    find_by_sql(sql)
  end
  private 
  def self.scrub_name_premerge(title)
    return title.gsub(".",'').gsub(" ",'').gsub(",",'').gsub(":", '').gsub(";","").gsub("'","").gsub("-","").downcase
  end
end
