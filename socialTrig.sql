/*Question 1

Write a trigger that makes new students named 'Friendly' automatically like 
everyone else in their grade. That is, after the trigger runs, we should have 
('Friendly', A) in the Likes table for every other Highschooler A in the same 
grade as 'Friendly'.

    Your triggers are created in SQLite, so you must conform to the trigger 
    constructs supported by SQLite.
*/
create Trigger FriendlyTrigger
after insert on Highschooler
for each row
where ID in (select ID as IDNum from Highschooler where grade = New.grade) and
(select ID1,ID2 from Likes where ID=ID1 or ID=ID2)
begin
    insert into Likes values (New.ID, IDNum);
end;
create Trigger FriendlyTrigger
after insert on Highschooler
for each row
begin
    select ID from Highschooler where name = 'Friendly' and 
    ID in (select ID from Highschooler where grade = New.grade) and
    ID in (select ID1 from Likes) and ID in (select ID2 from Likes);
    insert into Likes values (New.ID, ID);
end;
/*Question 2

Write one or more triggers to manage the grade attribute of new Highschoolers. 
If the inserted tuple has a value less than 9 or greater than 12, change the 
value to NULL. On the other hand, if the inserted tuple has a null value for 
grade, change it to 9.

    Your triggers are created in SQLite, so you must conform to the trigger 
    constructs supported by SQLite.
    To create more than one trigger, separate the triggers with a vertical 
    bar (|).
*/
create trigger HSGradeTrigger
after insert on Highschooler 
for each row
when  (9 > (select grade from Highschooler) and 12 < (select grade from Highschooler))
begin
    update Highschooler set grade=NULL where New.grade < 9 and New.grade > 12
|
create trigger HSGradeNullTrigger
after insert on Highschooler 
for each row
when (New.grade = NULL)
begin
   update Highschooler set grade=9 where New.grade = NULL
end;

create trigger HSGradeTrigger
after insert on Highschooler 
for each row
when (New.grade < 9 and New.grade > 12)
begin
update Highschooler set grade=NULL where New.grade < 9 and New.grade > 12
|
create trigger HSGradeNullTrigger
after insert on Highschooler 
for each row
when (New.grade = NULL)
begin
update Highschooler set grade=9 where New.grade = NULL
end;

/*Question 3

Write a trigger that automatically deletes students when they graduate, i.e., 
when their grade is updated to exceed 12.

    Your triggers are created in SQLite, so you must conform to the trigger 
    constructs supported by SQLite.
*/
create trigger HSGrad
after update on Highschooler
for each row
when (New.grade > 12)
begin
  delete from Highschooler where grade > 12;
end;
