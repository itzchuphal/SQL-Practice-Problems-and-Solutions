-- From the students table, write a SQL query to interchange the adjacent student names.
-- Note: If there are no adjacent student then the student name should stay the same.

-- Creating Table


create table students
    (
        id              int primary key,
        student_name    varchar(50) not null
    );
	

-- Inserting Values


insert into students values
    (1, 'James'),
    (2, 'Michael'),
    (3, 'George'),
    (4, 'Stewart'),
    (5, 'Robin');


-- Solution


select * 
,case when id % 2 = 0 then
 lag(student_name) over() 
 else
 lead(student_name, 1, student_name) over() 
 end as adjacent_student
from students;