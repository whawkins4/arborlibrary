--insert into checkouts(checked_out_on, user_id, copy_id)
select cast(checkout_time as Date), u.id, cp.id
from checkout_import chk join users u on cast(chk.user_id as integer) = cast(u.library_card as integer)
join copies cp on cast(chk.accession as integer)= cp.accession 
where length(chk.accession)=8
and not exists (select * from checkouts where checked_out_on = cast(checkout_time as Date) and user_id = u.id and copy_id = cp.id)