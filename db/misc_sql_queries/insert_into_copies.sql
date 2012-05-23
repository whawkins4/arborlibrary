insert into copies (book_id,catalog_date,copy_number, collection, source)
select id, date, copy, collection, source
from books
     