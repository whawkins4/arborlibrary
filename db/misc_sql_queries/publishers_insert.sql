delete from publishers;

insert into publishers (pub_name, pub_place) select distinct trim(coalesce(pub_name,'')), trim(coalesce(pub_place,'')) from original