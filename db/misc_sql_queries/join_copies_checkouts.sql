
select cop.* from copies cop join checkouts chk on cop.id = chk.copy_id
where chk.checked_in_on is null and chk.checked_out_on is not null 
