select * from authors where auth_last in (
select auth_last from authors group by auth_last, auth_first having count(*) >1
)
order by auth_last, auth_first