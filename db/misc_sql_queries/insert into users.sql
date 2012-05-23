
delete from users_import_temp where name = 'name';

select * from users_import_temp;

insert into users (name, library_card, grade) select * from users_import_temp;