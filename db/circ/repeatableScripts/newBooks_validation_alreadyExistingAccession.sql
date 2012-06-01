
DROP TABLE book_import;

CREATE TABLE book_import
(
timestamp character varying
, accession character varying
, dewey character varying
, cutter character varying
, copy character varying
, last character varying
, first character varying
, middle character varying
, title character varying
, subtitle character varying
, series character varying
, number character varying,
 format character varying,
 isbn character varying,
 lccn character varying,
 publisher character varying,
 place character varying,
 copyright character varying,
 illustrated character varying,
 type character varying,
 pages character varying,
 contributor1 character varying,
 contributor2 character varying,
 contributor3 character varying,
 subject1 character varying,
 subject2 character varying,
 subject3 character varying,
 subject4 character varying,
 subject5 character varying,
 subject6 character varying,
 subject7 character varying,
 subject8 character varying,
 summary character varying,
 collection character varying,
 price character varying,
 source character varying,
 awards_publicity character varying
)
WITH (
  OIDS=FALSE
);

ALTER TABLE book_import
  OWNER TO libraryadmin;

COPY book_import from '/Users/administrator/arborlibrary/db/circ/drop/newbooks.csv' with csv HEADER;

select i.accession, i.title, b.title, * from book_import i 
join copies c on cast(c.accession as character varying) = i.accession
join books b on c.book_id = b.id;


--select * from book_import where length(accession)<>8;

