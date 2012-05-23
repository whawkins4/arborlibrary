--select * from checkout_import where length(accession)<>8


--unrecognized accession numbers  (accession numbers in the checkin_import that don't match any book copy in the database)
select * from checkout_import where cast(accession as integer) not in (select accession from copies)
and length(accession)=8;

select * from checkout_import where length(user_id)>4;
-- not in (select library_card from users)

--select distinct user_id from checkout_import

select * from checkout_import order by length(checkout_time);
