
select b1.id from books b1 where title ilike '%dog%'
union 
select b2.id from books b2 join authors_books ab on b2.id = ab.book_id join authors a on ab.author_id = a.id
where a.auth_first ilike '%dog%' or a.auth_last ilike '%dog%'
union
select b3.id from books b3 join books_subjects bs on b3.id = bs.book_id join subjects s on bs.subject_id = s.id
where s.subject ilike '%dog%'
order by title
