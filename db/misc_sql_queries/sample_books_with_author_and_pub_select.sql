select b.title, a.auth_last,a.auth_first, p.pub_name from books b left join publishers p on b.publisher_id = p.id
left join authors_books ab on b.id = ab.book_id
left join authors a on ab.author_id = a.id
