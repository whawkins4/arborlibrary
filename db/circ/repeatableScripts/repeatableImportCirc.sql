-- Table: books

DROP TABLE checkin_import;

CREATE TABLE checkin_import
(
  checkin_time character varying(500),
  accession character varying(500)
  
)
WITH (
  OIDS=FALSE
);
ALTER TABLE checkin_import
  OWNER TO libraryadmin;

DROP TABLE checkout_import;

CREATE TABLE checkout_import
(
  checkout_time character varying(500),
  user_id character varying(500),
  accession character varying(500)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE checkout_import
  OWNER TO libraryadmin;

COPY checkin_import from '/Users/willhawkins/arborlibrary/db/circ/drop/checkins.csv' with csv;

COPY checkout_import from '/Users/willhawkins/arborlibrary/db/circ/drop/checkouts.csv' with csv;

delete from checkin_import where checkin_time ='Timestamp' or checkin_time = 'timestamp' or accession = 'accession';
delete from checkout_import where checkout_time ='Timestamp'or checkout_time = 'timestamp'  or accession = 'accession';



update checkout_import set user_id = trim(user_id);
update checkout_import set checkout_time = trim(checkout_time);


update checkout_import set checkout_time ='05/23/2011 03:01:42' where length(checkout_time)<4 or checkout_time is null;

update checkout_import set user_id = m.new from library_card_map m where m.old = checkout_import.user_id;

update checkout_import set user_id = '0' || user_id where length(user_id)<4;
update checkout_import set user_id = '0' || user_id where length(user_id)<4;
update checkout_import set user_id = '0' || user_id where length(user_id)<4;

update checkout_import set accession = trim(accession);


delete from checkout_import where length(accession) <> 8;


insert into checkouts(checked_out_on, user_id, copy_id)
select cast(checkout_time as Date), u.id, cp.id
from checkout_import chk join users u on chk.user_id= u.library_card
join copies cp on cast(chk.accession as integer)= cp.accession 
where chk.user_id is not null and length(chk.user_id)>0 and length(chk.accession)=8
and not exists (select * from checkouts where checked_out_on = cast(checkout_time as Date) and user_id = u.id and copy_id = cp.id);




--manually created column checkin_import.copy_id

alter table checkin_import add column copy_id integer;

alter table checkin_import add column checkin_time_casted timestamp;

update checkin_import set copy_id = c.id 
from copies c where cast(checkin_import.accession as integer) = c.accession;

update checkin_import set checkin_time_casted = cast(checkin_time as timestamp);

update checkouts set checked_in_on= now() where checked_in_on is null and 
	exists (select * from checkin_import i where i.copy_id = checkouts.copy_id and checkin_time_casted > checkouts.checked_out_on );



