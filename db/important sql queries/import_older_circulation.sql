-- Table: books

--drop table old_checkout_import;
--drop table old_checkin_import;


CREATE TABLE old_checkin_import
(
	accession character varying(500),
  
  checkin_time character varying(500)
  
)
WITH (
  OIDS=FALSE
);
ALTER TABLE checkin_import
  OWNER TO libraryadmin;



CREATE TABLE old_checkout_import
(
  card character varying(500),
  accession character varying(500),
  checkout_date character varying(500)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE checkout_import
  OWNER TO libraryadmin;

COPY old_checkin_import from '/Users/willhawkins/arborlibrary/db/circ/temp_checkins.csv' with csv;

COPY old_checkout_import from '/Users/willhawkins/arborlibrary/db/circ/temp_checkouts.csv' with csv;

insert into checkout_import(checkout_time, user_id, accession) 
select checkout_date, card, accession from old_checkout_import;

insert into checkin_import(checkin_time, accession)
select checkin_time, accession from old_checkin_import;
