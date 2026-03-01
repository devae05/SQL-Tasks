use day7;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept VARCHAR(50),
    city VARCHAR(50),
    salary INT
);

INSERT INTO employees VALUES
(1,'Ravi','IT','Chennai',50000),
(2,'Kumar','HR','Madurai',40000),
(3,'Anu','IT','Chennai',60000),
(4,'Priya','HR','Salem',45000),
(5,'Arun','IT','Coimbatore',70000);

create index idx_salary
on employees(salary);

create index idx_dept_city
on employees(dept, city);

create view it_high_salary as
select *
from employees
where dept = 'IT' and salary > 55000;
select * from it_high_salary;

create view hr_names as
select emp_name
from employees
where dept = 'HR';
select * from hr_names;

update it_high_salary
set salary = 55000
where emp_name = 'Ravi';
select * from it_high_salary;
