select ch.*,v.title,v.accession from checkouts ch join "copiesBooks" v on ch.copy_id = v.copy_id
where checked_in_on is  null
order by v.title,v.accession