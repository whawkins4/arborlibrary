select u.grade, u.last || ', ' || u.first as name, b.dewey, b.cutter, b.copy, b.title, chk.checked_out_on, c.accession from checkouts chk
 join copies c on chk.copy_id= c.id
 join books b on c.book_id = b.id
 left join users u on chk.user_id = u.id
 where chk.checked_in_on is null
 order by u.grade,u.last, u.first