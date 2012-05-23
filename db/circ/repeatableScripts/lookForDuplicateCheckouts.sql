select c.id, ck.id,b.title, c.accession,u.last, u.first,ck.* from copies c join checkouts ck on c.id = ck.copy_id 
join books b on c.book_id = b.id
join users u on u.id = ck.user_id
where ck.checked_in_on is null and
c.id in (select copy_id from checkouts where checked_in_on is null
group by copy_id having count(*) >1)
order by c.id, checked_out_on, ck.id