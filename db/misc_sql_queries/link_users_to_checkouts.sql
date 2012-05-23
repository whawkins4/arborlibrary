select cast(checkout_time as Date), u.id, cp.id
from checkout_import chk join users u on cast(chk.user_id as integer) = cast(u.library_card as integer)
join copies cp on cast(chk.accession as integer)= cp.accession 
where length(chk.accession)=8