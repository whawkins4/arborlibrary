select b.title, b.pub_name, b.pub_place, p.pub_name, p.pub_place from books b join publishers p on b.publisher_id = p.id
where b.pub_name <> p.pub_name or b.pub_place<> p.pub_place
