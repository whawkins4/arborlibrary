-- Table: books

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

COPY book_import from '/Users/willhawkins/arborlibrary/db/circ/drop/newbooks.csv' with csv;

delete from book_import where timestamp = 'timestamp';

delete from book_import where accession in (select cast(accession as character varying) from copies);

delete from book_import where length(accession)<>8;

update book_import set isbn = trim(isbn);


insert into books (date, title, series, format, isbn, lccn, copyright, illustrated, illus_type, pages, 
subject1, subject2, subject3, subject4, notes1, notes2, notes3, summary, awards_publicity) 
select timestamp, trim(title), series, format, trim(isbn), lccn, copyright, illustrated, type, pages,
 subject1, subject2, subject3, subject4, contributor1, contributor2, contributor3, summary, awards_publicity from book_import
 where trim(isbn) not in (select trim(isbn) from books);

/* at this stage in the process manually mark any duplicated isbns frm the new data with a D- prefix in one of them before proceeding to the next script */

/*
//dup isbns can hurt
select * from book_import where isbn in (select isbn from books group by isbn having count(*)>1)
*/

insert into copies (book_id,catalog_date,copy_number, collection, source, accession,dewey, cutter)
select b.id, i.timestamp, i.copy, i.collection, i.source, cast(i.accession as integer),dewey, cutter
from book_import i join books b  on trim(i.isbn) = trim(b.isbn)
where not exists (select * from copies c where c.accession = cast(i.accession as integer));




update book_import set last = trim(coalesce(last,''));
update book_import set first = trim(coalesce(first,''));
update book_import set middle = trim(coalesce(middle,''));

insert into authors (auth_last, auth_first, auth_middle) 
select distinct last, first, middle from book_import i
where not exists (select * from authors a where auth_last = last and auth_middle=middle and auth_first = first);


insert into authors_books(book_id,author_id, authorship_type)
select b.id, a.id, 0  from books b join book_import i on b.isbn = i.isbn
join authors a on a.auth_last = i.last and a.auth_middle=i.middle and a.auth_first = i.first
where not exists (select * from authors_books where book_id = b.id and author_id = a.id);

update book_import set 	publisher = regexp_replace(trim(coalesce(publisher,'')), ',$',''),place = regexp_replace(trim(coalesce(place,'')), ',$','');

insert into publishers (pub_name, pub_place) 
select distinct publisher, place from book_import where not exists (select * from publishers where pub_name = publisher and pub_place = place);

update books set publisher_id = s.pubid 
from 
 ( select o.isbn, p.id as pubid from book_import o join publishers p on o.publisher = p.pub_name and o.place = p.pub_place ) s
 where books.isbn = s.isbn
and books.publisher_id is null;


---notes 
--copies 87560 is the highest copyid before we start importing these new books
-- bookds 122608
-- authors 81664
--publishers 67242

--select * into cleanup_books_with_dup_isbns from book_import where isbn in (select isbn from books group by isbn having count(*) >1) ;;
--delete from book_import where isbn in (select isbn from books group by isbn having count(*) >1) 
