class Checkout < ActiveRecord::Base
  belongs_to :copy
  belongs_to :user
  def self.checked_out_copies
    Copy.find_by_sql('select cop.* from copies cop join checkouts chk on cop.id = chk.copy_id where cop.deleted=false and cop.deaccessioned = false and chk.checked_in_on is null and chk.checked_out_on is not null')
  end
  def self.active_checkouts
    Checkout.find_by_sql('select * from checkouts where checked_in_on is null')
  end

  def self.checkin(accession)
    copy = Copy.find_by_accession(accession)
    throw "unidentified accession" unless copy
    outs = copy.checkouts.where('checked_in_on is null')

    outs.each {|o| 
      o.checked_in_on = DateTime.now
      o.save!
    }
    return copy
  end
  def self.outstanding_count
    self.checkout_report_data.num_tuples
  end
  def self.checkout_report_data 

    sql="select u.grade, u.last || ', ' || u.first as name, c.dewey, c.cutter, c.copy_number as copy, b.title, chk.checked_out_on, c.accession from checkouts chk
    join copies c on chk.copy_id= c.id
    join books b on c.book_id = b.id
    left join users u on chk.user_id = u.id
    where c.deleted=false and c.deaccessioned = false and chk.checked_in_on is null
    order by u.grade,u.last, u.first"

    return self.connection.execute(sql)

  end
  def self.checkout_by_accession(accession, user)
    copy = Copy.find_by_accession(accession)

    return self.checkout_copy(copy, user)

  end
  def self.checkout_copy(copy, user) 
    if copy and user
      if copy.available?
        checkout = Checkout.new
        checkout.copy = copy
        checkout.user = user
        checkout.checked_out_on = Time.now
      else
        throw "The book is checked out by somebody else."
      end
    else 
      throw "Copy not found." if !copy
      throw "User not found." if !user
    end
    return checkout
  end
end
