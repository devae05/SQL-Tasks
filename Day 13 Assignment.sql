create database joins_assignment;
use joins_assignment;

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

select e.*
from employees e
join departments d on e.dept_id = d.dept_id
where e.salary > (select avg(salary) from employees);

select e.*
from employees e
join departments d on e.dept_id = d.dept_id
where d.dept_name='it';

select *
from employees
where salary = (select max(salary) from employees);

select *
from employees
where dept_id is null;

select distinct e.*
from employees e
join emp_projects ep on e.emp_id = ep.emp_id;

select e.*
from employees e
left join emp_projects ep on e.emp_id = ep.emp_id
where ep.project_id is null;

select distinct d.*
from departments d
join employees e on d.dept_id = e.dept_id;

select d.*
from departments d
left join employees e on d.dept_id = e.dept_id
where e.emp_id is null;

select e.*
from employees e
join employees m on e.manager_id = m.emp_id
where e.salary > m.salary;

select e.*
from employees e
join locations l on e.dept_id = l.dept_id
where l.city='tokyo';

select e.*
from employees e
join emp_projects ep on e.emp_id = ep.emp_id
join projects p on ep.project_id = p.project_id
where p.project_name='website';

select distinct p.*
from projects p
join emp_projects ep on p.project_id = ep.project_id
join employees e on ep.emp_id = e.emp_id
join departments d on e.dept_id = d.dept_id
where d.dept_name='it';

select *
from employees
where emp_id in (select manager_id from employees where manager_id is not null);

select *
from employees
where emp_id not in (select manager_id from employees where manager_id is not null);

select distinct d.*
from departments d
join projects p on d.dept_id = p.dept_id;

select d.*
from departments d
left join projects p on d.dept_id = p.dept_id
where p.project_id is null;

select e.*
from employees e
join (
select dept_id, avg(salary) avg_sal
from employees
group by dept_id
) x on e.dept_id = x.dept_id
where e.salary > x.avg_sal;

select distinct salary
from employees
order by salary desc
limit 1,1;

select e.*
from employees e
join (
select dept_id
from employees
group by dept_id
having count(*)>1
) x on e.dept_id = x.dept_id;

select e.*
from employees e
join locations l on e.dept_id = l.dept_id;

select e.*
from employees e
left join locations l on e.dept_id = l.dept_id
where l.location_id is null;

select distinct p.*
from projects p
join employees e on p.dept_id = e.dept_id;

select e.*
from employees e
join emp_projects ep on e.emp_id = ep.emp_id
join projects p on ep.project_id = p.project_id
where e.dept_id = p.dept_id;

select e.*
from employees e
join emp_projects ep on e.emp_id = ep.emp_id
join projects p on ep.project_id = p.project_id
where e.dept_id <> p.dept_id;

select d.*
from departments d
join employees e on d.dept_id = e.dept_id
group by d.dept_id,d.dept_name
having min(e.salary) > 50000;
