update books b set pub_name = 
(select id from publishers p join original o on p.pub_name = o.pub_name and o.pub_place = p.pub_place where cast(o.accession as integer) = b.accession and length(p.pub_name)>0)
