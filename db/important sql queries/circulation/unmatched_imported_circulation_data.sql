select * from checkout_import where accession  not in (select cast(accession as character varying) from copies)
