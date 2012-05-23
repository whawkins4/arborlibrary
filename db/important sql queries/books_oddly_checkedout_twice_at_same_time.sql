select  u.first, u.last, b.title, c.* from checkouts c
 join users u on c.user_id = u.id
 join copies cp on c.copy_id = cp.id
 join books b on cp.book_id = b.id
where c.copy_id in (
select copy_id from checkouts where checked_in_on is null  group by copy_id having count(*) >1 )
and c.checked_in_on is null
order by c.copy_id, c.checked_out_on;


--delete from checkouts where id in (5695, 218, 341);