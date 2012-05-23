-- Table: books

DROP TABLE original;

CREATE TABLE original
(
  accession character varying(500),
  date character varying(500),
  dewey character varying(500),
  cutter character varying(500),
  copy character varying(500),
  auth_last character varying(500),
  auth_first character varying(500),
  auth_middle character varying(500),
  title character varying(500),
  series character varying(500),
  format character varying(500),
  isbn character varying(500),
  lccn character varying(500),
  pub_name character varying(500),
  pub_place character varying(500),
  copyright character varying(500),
  illustrated character varying(500),
  illus_type character varying(500),
  pages character varying(500),
  subject1 character varying(500),
  subject2 character varying(500),
  subject3 character varying(500),
  subject4 character varying(500),
  notes1 character varying(500),
  notes2 character varying(500),
  notes3 character varying(500),
  summary character varying(500),
  awards_publicity character varying(500),
  collection character varying(500),
  source character varying(500)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE original
  OWNER TO libraryadmin;
