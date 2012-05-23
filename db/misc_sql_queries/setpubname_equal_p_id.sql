update books b set books.pub_name = p.id
from b join original o on books.accession = cast(o.accession as integer)
join publishers p on p.pub_name = o.pub_name and p.pub_place = o.pub_place
where length(p.pub_name)>0