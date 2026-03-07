
create table cust_pk(
cid int primary key,
cname varchar(30),
address varchar(100),
mobile bigint,
email varchar(30)
);

insert into cust_pk values
(1,'kumar','bangalore',1234567890,'kumar@gmail.com'),
(2,'suresh','bangalore',1244467890,'suresh@gmail.com'),
(3,'raj','bangalore',1232267890,'raj@gmail.com');



create table cust_pk_constraint(
cid int,
cname varchar(30),
address varchar(100),
mobile bigint,
email varchar(30),
constraint pk_customer primary key(cid)
);

insert into cust_pk_constraint values
(1,'kumar','bangalore',1234567890,'kumar@gmail.com'),
(2,'suresh','bangalore',1244467890,'suresh@gmail.com'),
(3,'raj','bangalore',1232267890,'raj@gmail.com');



create table cust_composite_pk(
cid int,
deptno int,
cname varchar(30),
address varchar(100),
mobile bigint,
email varchar(30),
constraint pk_comp primary key(cid,deptno)
);

insert into cust_composite_pk values
(1,10,'kumar','bangalore',1234567890,'kumar@gmail.com'),
(2,20,'suresh','bangalore',1244467890,'suresh@gmail.com'),
(3,10,'raj','bangalore',1232267890,'raj@gmail.com');



create table cust_unique(
cid int unique,
cname varchar(30),
address varchar(100),
mobile bigint,
email varchar(30)
);

insert into cust_unique values
(1,'kumar','bangalore',1234567890,'kumar@gmail.com'),
(2,'suresh','bangalore',1244467890,'suresh@gmail.com'),
(3,'raj','bangalore',1232267890,'raj@gmail.com'),
(null,'raj','bangalore',1232267890,'raj@gmail.com');



create table cust_unique_alter(
cid int,
cname varchar(30),
address varchar(100),
mobile bigint,
email varchar(30)
);

alter table cust_unique_alter
add constraint uk_cid unique(cid);

insert into cust_unique_alter values
(1,'kumar','bangalore',1234567890,'kumar@gmail.com'),
(2,'suresh','bangalore',1244467890,'suresh@gmail.com'),
(3,'raj','bangalore',1232267890,'raj@gmail.com');



create table dept_fk(
did int primary key,
dname varchar(20)
);

insert into dept_fk values
(10,'it'),
(20,'bpo'),
(30,'hr');



create table emp_fk(
eno int primary key,
ename varchar(30),
desg varchar(20),
salary int,
deptno int,
constraint fk_dept foreign key(deptno)
references dept_fk(did)
);

insert into emp_fk values
(101,'sam','developer',25000,10),
(102,'alan','tl',45000,20),
(103,'joe','manager',60000,10);



create table emp_check(
empno int primary key,
ename varchar(20),
city varchar(20),
state char(2),
constraint ck_state check(state in('tn','ap','kl'))
);

insert into emp_check values
(101,'sam','chennai','tn'),
(102,'alan','vijayawada','ap'),
(103,'joe','kochi','kl');



create table emp_default(
empno int primary key,
ename varchar(20),
city varchar(20) default 'chennai',
state char(2),
constraint ck_state2 check(state in('tn','ap','kl'))
);

insert into emp_default values
(201,'kumar','trichy','tn');

insert into emp_default values
(202,'raj',default,'ap');

insert into emp_default(empno,ename,state)
values(203,'arun','tn');

select * from emp_default;
