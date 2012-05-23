delete from authors_books;
delete from authors;
delete from books;
delete from copies;
delete from publishers;
delete from checkouts;

insert into books (accession, date, dewey, cutter, copy, title, series, format, isbn, lccn, copyright, illustrated, illus_type, pages, subject1, subject2, subject3, subject4, notes1, notes2, notes3, summary, awards_publicity, collection, source) 
select cast(accession as integer), date, dewey, cutter, copy, title, series, format, isbn, lccn, copyright, illustrated, illus_type, pages, subject1, subject2, subject3, subject4, notes1, notes2, notes3, summary, awards_publicity, collection, source from original;

insert into authors (auth_last, auth_first, auth_middle) select distinct trim(coalesce(auth_last,'')), trim(coalesce(auth_first,'')), trim(coalesce(auth_middle,'')) from original;

insert into publishers (pub_name, pub_place) select distinct trim(coalesce(pub_name,'')), trim(coalesce(pub_place,'')) from original;


insert into authors_books(book_id,author_id)
select b.id, a.id from books b join original o on b.accession = cast(o.accession as integer)
join authors a on a.auth_last = o.auth_last and a.auth_middle=o.auth_middle and a.auth_first = o.auth_first;



update books set publisher_id = s.pubid 
from 
 ( select cast(o.accession as integer) as acc, p.id as pubid from original o join publishers p on o.pub_name = p.pub_name and o.pub_place = p.pub_place ) s
 where books.accession = s.acc;
 

insert into copies (book_id,catalog_date,copy_number, collection, source, accession)
select id, date, copy, collection, source, accession
from books;
     

