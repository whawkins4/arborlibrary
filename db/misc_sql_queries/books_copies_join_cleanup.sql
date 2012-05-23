select b1.title, b2.title, * 
from books b1 join books b2 on b1.isbn=b2.isbn
where b1.title <> b2.title and b1.id<>b2.id and length(coalesce(b1.isbn,''))>0
