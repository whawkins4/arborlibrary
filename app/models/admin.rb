class Admin
  def self.authorless_books 
    Book.find_by_sql ("select * from books
    where id not in (select book_id from authors_books)
    order by title")
    
  end
  def self.books_with_dup_isbn
  Book.find_by_sql "select * from books where deleted = false and isbn in (select isbn from books where length(coalesce(isbn,''))>0  group by isbn having count(*) > 1)
  order by isbn, title"
  end
  
  def self.books_with_dup_title
  Book.find_by_sql "select * from books where deleted = false and title in (select title from books where length(coalesce(title,''))>0 group by title having count(*) > 1)
  order by title, isbn"
  end
  
  def self.clean_dup_checkouts
    #for the same user at the same time
    #this deletes checkout cases where the same user at the same time some how checked out the same book
    #over and over and over in the interim system
    
    sql = "select * from checkouts ck join (
    select copy_id, user_id, count(*) from checkouts where checked_in_on is null group by copy_id, user_id having count(*) > 1
    ) crazy on ck.copy_id = crazy.copy_id and ck.user_id = crazy.user_id 
    where checked_in_on is null
    order by ck.copy_id, ck.user_id, ck.checked_out_on"
    
    checkouts = Checkout.find_by_sql(sql)
    
    copy_id = nil
    user_id = nil
    checked_out_on = nil
  
    checkouts.each do |ck|
      if ck.copy_id == copy_id and ck.user_id == user_id and ck.checked_out_on = checked_out_on
        ck.destroy
        puts "destroying #{ck.id} copyid=#{ck.copy_id} userid = #{ck.user_id}"
      else
        copy_id = ck.copy_id
        user_id = ck.user_id
        checked_out_on = ck.checked_out_on
      end
    end
  end
  
  def self.clean_dup_checkouts_different_users
    
    
  sql="select ck.* 
  from checkouts ck
  where ck.checked_in_on is null and
  ck.copy_id in (select copy_id from checkouts where checked_in_on is null
  group by copy_id having count(*) >1)
  order by ck.copy_id, ck.checked_out_on, ck.id"
  
  checkouts = Checkout.find_by_sql(sql)
  
  copy_id = nil
  user_id = nil
  checked_out_on = nil
  last_checkout = nil
  checkouts.each do |ck|
    if ck.copy_id == copy_id 
      last_checkout.checked_in_on = ck.checked_out_on
      last_checkout.save!
      puts "updating #{last_checkout.id} copyid=#{ck.copy_id} userid = #{last_checkout.user_id} now checked_in_on #{ck.checked_out_on}"
    else
      copy_id = ck.copy_id
    end
    last_checkout = ck
  end
end
end