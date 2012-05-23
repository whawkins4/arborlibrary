select cast(checkout_time as Date), u.id, cp.id
from checkout_import chk join users u on cast(chk.user_id as integer) = u.id
join copies cp on cast(chk.accession as integer)= cp.accession 
