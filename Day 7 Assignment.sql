CREATE TABLE students1 (id INT,class VARCHAR(10),name VARCHAR(50),marks INT);
INSERT INTO students1 VALUES(1, 'A', 'John', 85),(2, 'A', 'Sara', 92),(3, 'A', 'Mike', 78),(4, 'B', 'Anna', 88),(5, 'B', 'Tom', 90);

CREATE TABLE exam1 (student VARCHAR(50),subject VARCHAR(20),score INT);
INSERT INTO exam1 VALUES('Alice', 'Math', 90),('Bob', 'Math', 90),('Charlie', 'Math', 85),('David', 'Science', 88),('Eva', 'Science', 88);

CREATE TABLE employees11 (emp_name VARCHAR(50),department VARCHAR(20),salary INT);
INSERT INTO employees11 VALUES('Alex', 'IT', 7000),('Brian', 'IT', 7000),('Chris', 'IT', 6500),('Diana', 'HR', 6000),('Eva', 'HR', 5800);

CREATE TABLE orders (order_id INT,order_date DATE, amount INT);
INSERT INTO orders VALUES(1, '2024-01-01', 100),(2, '2024-01-02', 200),(3, '2024-01-03', 150),(4, '2024-01-04', 300);

CREATE TABLE monthly_sales (month VARCHAR(10), sales INT);
INSERT INTO monthly_sales VALUES('Jan', 5000),('Feb', 6000),('Mar', 5500),('Apr', 7000);

select *,
row_number() over (partition by class order by marks desc) as row_num
from students1;

select *,
rank() over (partition by class order by marks desc) as rank_no
from students1;

select *,
dense_rank() over (partition by class order by marks desc) as rank_no
from students1;

select *,
avg(marks) over (partition by class) as avg_marks
from students1;

select *,
max(marks) over (partition by class) as highest_marks
from students1;

select *,
row_number() over (partition by subject order by score desc) as row_no
from exam1;

select *,
rank() over (partition by subject order by score desc) as rank_no
from exam1;

select *,
dense_rank() over (partition by subject order by score desc) as rank_no
from exam1;

select *,
count(*) over (partition by subject) as total_students
from exam1;

select *,
min(score) over (partition by subject) as min_score
from exam1;

select *,
row_number() over (partition by department order by salary desc) as row_no
from employees11;

select *,
rank() over (partition by department order by salary desc) as rank_no
from employees11;

select *,
dense_rank() over (partition by department order by salary desc) as rank_no
from employees11;

select *,
sum(salary) over (partition by department) as total_salary
from employees11;

select *,
avg(salary) over (partition by department) as avg_salary
from employees11;

select *,
row_number() over (order by order_date) as row_no
from orders;

select *,
sum(amount) over (order by order_date) as running_total
from orders;

select *,
avg(amount) over (order by order_date rows 1 preceding) as moving_avg
from orders;

select *,
max(amount) over (order by order_date) as max_till_now
from orders;

select *,
count(*) over () as total_orders
from orders;

select *,
row_number() over (order by month) as row_no
from monthly_sales;

select *,
lag(sales) over (order by month) as prev_month
from monthly_sales;

select *,
lead(sales) over (order by month) as next_month
from monthly_sales;

select *,
sales - lag(sales) over (order by month) as difference
from monthly_sales;

select *,
sum(sales) over (order by month) as cumulative_sales
from monthly_sales;
