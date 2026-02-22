create database day10;
use day10;

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    dept VARCHAR(50),
    city VARCHAR(50),
    salary INT
);

-- 1.Create index on salary column.

CREATE INDEX idx_salary
ON Employees(salary);

-- 2.Create composite index for dept + city.

CREATE INDEX idx_dept_city
ON Employees(dept, city);

-- 3.Create view showing only IT employees earning above 55,000.

CREATE VIEW IT_HighSalary AS
SELECT *
FROM Employees
WHERE dept = 'IT' AND salary > 55000;

-- 4.Create view for HR employee names only.

CREATE VIEW HR_EmployeeNames AS
SELECT name
FROM Employees
WHERE dept = 'HR';

-- 5.Update salary of Ravi to 55,000 using view.

UPDATE IT_HighSalary
SET salary = 55000
WHERE name = 'Ravi';
