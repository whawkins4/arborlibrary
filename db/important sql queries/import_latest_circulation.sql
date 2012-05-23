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

COPY checkin_import from '/Users/willhawkins/arborlibrary/db/checkins_4_2_2012.csv' with csv;

COPY checkout_import from '/Users/willhawkins/arborlibrary/db/checkouts_4_2_2012.csv' with csv;

delete from checkin_import where checkin_time ='Timestamp';
delete from checkout_import where checkout_time ='Timestamp';



