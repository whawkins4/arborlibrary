
insert into subjects(subject) 
select distinct trim(subject1) from books where length(trim(subject1))>0
and not exists (select * from subjects s where s.subject = trim(subject1));

insert into subjects(subject) 
select distinct trim(subject2) from books where length(trim(subject2))>0
and not exists (select * from subjects s where s.subject = trim(subject2));

insert into subjects(subject) 
select distinct trim(subject3) from books where length(trim(subject3))>0
and not exists (select * from subjects s where s.subject = trim(subject3));

insert into subjects(subject) 
select distinct trim(subject4) from books where length(trim(subject4))>0
and not exists (select * from subjects s where s.subject = trim(subject4));

delete from subjects where length(subject)<=2;

insert into books_subjects(book_id, subject_id) 
select b.id, s.id from 
books b join subjects s on trim(b.subject1) = s.subject
and not exists (select * from books_subjects bs where bs.book_id = b.id and bs.subject_id = s.id);

insert into books_subjects(book_id, subject_id) 
select b.id, s.id from 
books b join subjects s on trim(b.subject2) = s.subject
and not exists (select * from books_subjects bs where bs.book_id = b.id and bs.subject_id = s.id);

insert into books_subjects(book_id, subject_id) 
select b.id, s.id from 
books b join subjects s on trim(b.subject3) = s.subject
and not exists (select * from books_subjects bs where bs.book_id = b.id and bs.subject_id = s.id);

insert into books_subjects(book_id, subject_id) 
select b.id, s.id from 
books b join subjects s on trim(b.subject4) = s.subject
and not exists (select * from books_subjects bs where bs.book_id = b.id and bs.subject_id = s.id);



