update checkout_import set user_id = trim(user_id);
update checkout_import set checkout_time = trim(checkout_time);


update checkout_import set checkout_time ='04/01/2011 12:23:42' where length(checkout_time)<4 or checkout_time is null;

update checkout_import set user_id = m.new from library_card_map m where m.old = checkout_import.user_id;

update checkout_import set user_id = '0' || user_id where length(user_id)<4;
update checkout_import set user_id = '0' || user_id where length(user_id)<4;
update checkout_import set user_id = '0' || user_id where length(user_id)<4;

update checkout_import set accession = trim(accession);

insert into checkouts(checked_out_on, user_id, copy_id)
select cast(checkout_time as Date), u.id, cp.id
from checkout_import chk join users u on cast(chk.user_id as integer) = cast(u.library_card as integer)
join copies cp on cast(chk.accession as integer)= cp.accession 
where length(chk.accession)=8
and not exists (select * from checkouts where checked_out_on = cast(checkout_time as Date) and user_id = u.id and copy_id = cp.id)