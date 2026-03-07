create database procedure1;
use procedure1;

create table company( cid int, cname varchar(50), email varchar(50), salary int, desg varchar(50), deptno int);

INSERT INTO company (cid, cname, email, salary, desg, deptno) VALUES
(1, 'Arun Kumar', 'arun@company.com', 45000, 'Developer', 101),
(2, 'Priya Sharma', 'priya@company.com', 52000, 'HR', 102),
(3, 'Rahul Verma', 'rahul@company.com', 60000, 'Manager', 103),
(4, 'Sneha Iyer', 'sneha@company.com', 48000, 'Developer', 101),
(5, 'Karthik R', 'karthik@company.com', 75000, 'Team Lead', 103);
truncate table company;
delimiter //
drop procedure if exists sel_pro ;
create procedure sel_pro()
begin
	select * from company;
end //
delimiter ;

call sel_pro;

delimiter //
drop procedure if exists sel_pro2 ;
create procedure sel_pro2(_cid int)
begin
	select * from company
    where cid = _cid;
end //
delimiter ;

call sel_pro2(4);

delimiter //
drop procedure if exists ins_pro ;
create procedure ins_pro( _cid int, _cname varchar(50), _email varchar(50), _salary int, _desg varchar(50), _deptno int)
begin
	insert into company values(_cid, _cname, _email, _salary, _desg, _deptno);
end //
delimiter ;

call ins_pro(6, 'Divya Nair', 'divya@company.com', 39000, 'Support', 104);

delimiter //
drop procedure if exists upt_pro ;
create procedure upt_pro( _cid int, _cname varchar(50), _email varchar(50), _salary int, _desg varchar(50), _deptno int)
begin
	update company 
    set cname = _cname,
		email = _email,
        salary = _salary,
        desg = _desg,
        deptno = _deptno
	where cid = _cid;
end //
delimiter ;

call upt_pro(6, 'Vikram Singh', 'vikram@company.com', 67000, 'Analyst', 105);

delimiter //
drop procedure if exists del_pro //
create procedure del_pro(_cid int)
begin
	delete from company where cid = _cid;
end //
delimiter ;

call del_pro(6);




delimiter //
drop procedure if exists del_all //
create procedure del_all()
begin
	delete from company;
end //
delimiter ;



delimiter //
drop procedure if exists poutCompany //
create procedure poutCompany(OUT a INT, OUT b INT, OUT c INT, OUT d INT, OUT e INT)
begin
	select count(salary),
	       sum(salary),
	       avg(salary),
	       min(salary),
	       max(salary)
	into a,b,c,d,e
	from company;
end //
delimiter ;

call poutCompany(@a,@b,@c,@d,@e);

select 
@a as total_employee,
@b as total_salary,
@c as avg_salary,
@d as min_salary,
@e as max_salary;


delimiter //
drop procedure if exists SalaryCalculate //
create procedure SalaryCalculate()
begin
	select cid,
	cname,
	salary as basic_salary,
	salary*40/100 as hra,
	salary*10/100 as da,
	salary*12/100 as pf,
	salary+(salary*40/100)+(salary*10/100)-(salary*12/100) as net_salary
	from company;
end //
delimiter ;

call SalaryCalculate();


delimiter //
drop procedure if exists CalculateSalaryTax //
create procedure CalculateSalaryTax()
begin
	select cid,
	cname,
	salary as basic_salary,
	salary*40/100 as hra,
	salary*10/100 as da,
	salary*12/100 as pf,
	salary+(salary*40/100)+(salary*10/100)-(salary*12/100) as net_salary,

	case
		when (salary+(salary*40/100)+(salary*10/100)-(salary*12/100)) <= 25000 then 0
		when (salary+(salary*40/100)+(salary*10/100)-(salary*12/100)) between 25001 and 50000
		then (salary+(salary*40/100)+(salary*10/100)-(salary*12/100))*10/100
		else (salary+(salary*40/100)+(salary*10/100)-(salary*12/100))*20/100
	end as tax_amount

	from company;
end //
delimiter ;

call CalculateSalaryTax();


delimiter //
drop procedure if exists nth_salary //
create procedure nth_salary(IN _n int)
begin
	declare offset_val int;
	set offset_val = _n - 1;

	select distinct salary
	from company
	order by salary desc
	limit offset_val,1;

end //
delimiter ;

call nth_salary(3);

select * from company;
