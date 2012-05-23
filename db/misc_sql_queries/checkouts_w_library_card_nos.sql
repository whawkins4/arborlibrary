select chk.* from checkout_import chk left join users u on chk.user_id = u.library_card
where u.library_card is null