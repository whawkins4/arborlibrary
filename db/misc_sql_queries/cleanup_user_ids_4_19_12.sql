update checkout_import set user_id = trim(user_id);

update checkout_import set user_id = '0' || user_id where length(user_id)<4;
update checkout_import set user_id = '0' || user_id where length(user_id)<4;
update checkout_import set user_id = '0' || user_id where length(user_id)<4;

select user_id from checkout_import where not exists (select * from users where library_card = checkout_import.user_id) order by user_id