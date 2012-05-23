--manually created column checkin_import.copy_id

update checkin_import set copy_id = c.id 
from copies c where cast(checkin_import.accession as integer) = c.accession;

update checkin_import set checkin_time_casted = cast(checkin_time as timestamp);

update checkouts set checked_in_on= now() where checked_in_on is null and 
	exists (select * from checkin_import i where i.copy_id = checkouts.copy_id and checkin_time_casted > checkouts.checked_out_on );

