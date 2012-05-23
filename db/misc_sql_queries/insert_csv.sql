delete from original;

COPY original from '/Users/willhawkins/arborlibrary/db/original.csv' with csv;

delete from original where accession = 'accession';

update original set auth_last = trim(coalesce(auth_last,'')),
	auth_first = trim(coalesce(auth_first,'')),
	auth_middle = trim(coalesce(auth_middle,'')),
	pub_name = regexp_replace(trim(coalesce(pub_name,'')), ',$',''),
	pub_place = regexp_replace(trim(coalesce(pub_place,'')), ',$',''),
	title = trim(coalesce(title,'')),
	isbn = trim(coalesce(isbn,'')),
	accession = trim(coalesce(accession,''));

delete from original where length(accession)<8 or length(accession)>9 	