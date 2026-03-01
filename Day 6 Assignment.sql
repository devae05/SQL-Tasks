create database day6;
use day6;

CREATE TABLE departments (dept_id INT,dept_name VARCHAR(50));
CREATE TABLE employees (emp_id INT,emp_name VARCHAR(50),dept_id INT,manager_id INT,salary INT);
CREATE TABLE projects (project_id INT,project_name VARCHAR(50),dept_id INT);
CREATE TABLE emp_projects (emp_id INT,project_id INT);
CREATE TABLE locations (location_id INT,dept_id INT,city VARCHAR(50));

INSERT INTO departments VALUES(1, 'IT'),(2, 'HR'),(3, 'Finance'),(4, 'Sales');
INSERT INTO employees VALUES(1, 'Alice', 1, NULL, 80000),(2, 'Bob', 1, 1, 60000),(3, 'Charlie', 2, 1, 50000),(4, 'David', 3, 2, 70000),(5, 'Eva', NULL, 2, 45000);
INSERT INTO projects VALUES(101, 'Website', 1),(102, 'Payroll', 3),(103, 'Recruitment', 2);
INSERT INTO emp_projects VALUES(1, 101),(2, 101),(3, 103),(4, 102);
INSERT INTO locations VALUES(1, 1, 'New York'),(2, 2, 'London'),(3, 3, 'Tokyo');

-- 1.Find employees who earn more than the average salary.

select emp_id, emp_name
from employees 
where salary >(select avg(salary) 
	from employees
);

-- 2.Find employees who work in the IT department.

select emp_name
from employees
where dept_id in(
	select distinct dept_id
    from departments
    where dept_name = "IT");

-- 3.Find employees who earn the highest salary.

select emp_name, salary
from employees
where salary = (
	select max(salary)
    from employees);
    
-- 4.Find employees who do not belong to any department.

select emp_name
from employees
where dept_id is null or dept_id not in (
	select dept_id
    from departments
);

-- 5.Find employees working on at least one project.

select emp_id, emp_name
from employees 	 
where emp_id in (
	select distinct emp_id
    from emp_projects);	
    
-- 6.Find employees NOT working on any project.

select emp_id, emp_name
from employees 
where emp_id not in (
	select emp_id
    from emp_projects );
    
-- 7.Find departments that have at least one employee.

select dept_name
from departments 
where dept_id in(
	select dept_id
    from employees);
    
-- 8.Find departments with no employees.

select dept_name
from departments
where dept_id not in (
	select dept_id
    from employees
);

-- 9.Find employees who earn more than their manager. (Correlated)

select e.emp_id, e.emp_name, e.salary
from employees e
where e.salary > (
    select m.salary
    from employees m
    where m.emp_id = e.manager_id
);

-- 10.Find employees who work in departments located in Tokyo.

select emp_name
from employees
where dept_id in (
	select dept_id
    from locations
    where city = "tokyo");
 
-- 11.Find employees working on the “Website” project.

select emp_name
from employees
where dept_id in(
	select dept_id 
    from projects
    where project_name = "website");
    
-- 12.Find projects assigned to employees from IT department.

select project_name
from projects
where project_id in(
	select project_id
    from emp_projects
    where emp_id in(
		select emp_id
        from employees
        where dept_id in(
			select dept_id
            from departments
            where dept_name = "it")));
            
-- 13.Find employees who are managers.

select emp_name
from employees
where emp_id in(
	select manager_id
    from employees
    where manager_id is not null);
    
-- 14.Find employees who are NOT managers.

select emp_name
from employees 
where emp_id not in(
	select manager_id 
    from employees
    where manager_id is not null);
    
-- 15.Find departments that have projects.

select dept_name
from departments
where dept_id in(
	select dept_id
    from projects);
    
-- 16.Find departments that do not have projects.

select dept_name
from departments
where dept_id not in (
    select dept_id
    from projects
);

-- 17.find employees who earn more than the average salary of their department

select emp_name, salary
from employees e
where salary > (
    select avg(salary)
    from employees
    where dept_id = e.dept_id
);

-- 18.find the second highest salary

select max(salary)
from employees
where salary < (
    select max(salary)
    from employees
);

-- 19.find employees working in departments with more than one employee

select emp_name
from employees
where dept_id in (
    select dept_id
    from employees
    group by dept_id
    having count(*) > 1
);

-- 20.find employees whose department has a location

select emp_name
from employees
where dept_id in (
    select dept_id
    from locations
);

-- 21.find employees whose department does not have a location

select emp_name
from employees
where dept_id not in (
    select dept_id
    from locations
);

-- 22.find projects belonging to departments with employees

select project_name
from projects
where dept_id in (
    select dept_id
    from employees
);

-- 23.find employees who work on projects from their own department

select emp_name
from employees
where emp_id in (
    select ep.emp_id
    from emp_projects ep
    join projects p on ep.project_id = p.project_id
    where p.dept_id = employees.dept_id
);

-- 24.find employees who work on projects outside their department

select emp_name
from employees
where emp_id in (
    select ep.emp_id
    from emp_projects ep
    join projects p on ep.project_id = p.project_id
    where p.dept_id <> employees.dept_id
);

-- 25.find departments where all employees earn more than 50000

select dept_name
from departments d
where not exists (
    select *
    from employees e
    where e.dept_id = d.dept_id
    and e.salary <= 50000
);

select * from departments;
select * from employees;
select * from projects;
select * from emp_projects;
select * from locations;
