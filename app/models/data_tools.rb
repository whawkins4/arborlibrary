class DataTools < ActiveRecord::Base
  def self.run(sql)
    self.connection.execute(sql)
  end

  def self.clearall
    Book.delete_all
    Author.delete_all
    Publisher.delete_all
  end

  def self.moveBooks
  run('insert into books (accession, date, dewey, cutter, copy, auth_last, auth_first, auth_middle, title, series, format, isbn, lccn, pub_name, pub_place, copyright, illustrated, illus_type, pages, subject1, subject2, subject3, subject4, notes1, notes2, notes3, summary, awards_publicity, collection, source) select accession, date, dewey, cutter, copy, auth_last, auth_first, auth_middle, title, series, format, isbn, lccn, pub_name, pub_place, copyright, illustrated, illus_type, pages, subject1, subject2, subject3, subject4, notes1, notes2, notes3, summary, awards_publicity, collection, source from original')
  end
  
  def self.movePublishers
  run('insert into publishers (pub_name, pub_place) select distinct trim(coalesce(pub_name,'')), trim(coalesce(pub_place,'')) from original')
  end
  
  def self.moveAuthors
    run('insert into authors (auth_last, auth_first, auth_middle) select distinct trim(coalesce(auth_last,'')), trim(coalesce(auth_first,'')), trim(coalesce(auth_middle,'')) from original')
  end
  

  def self.moveall
    self.moveBooks
    self.moveAuthors
    self.movePublishers
  end

  def self.reseed
    clearall
    moveall
  end

end