use avi;

create table employees(
employee_id int,
first_name varchar(20),
last_name varchar(20),
hourly_pay decimal(5,2),
hire_date date
);
insert into employees
values
(1,"Eugene","krabs",25.50,"2023-01-02"),
(2,"squidward","tentacles",15.00,"2023-01-03"),
(3,"spongebob","squarepants",12.50,"2023-01-04"),
(4,"patrick","star",12.50,"2023-01-05"),
(5,"sandy","cheeks",17.25,"2023-01-06");

alter table employees
add column  full_name varchar(30) after last_name;

set sql_safe_updates=0;
update employees
set full_name=concat(first_name," ",last_name); # DON'T USE QUOTES FOR FIRST_NAME AND LAST_NAME

alter table employees
drop column full_name;

alter table employees
add column job varchar(25) after hourly_pay;


select* from employees;


update employees
set job="manager"
where employee_id="1";

update employees
set job="cashier"
where employee_id="2";

update employees
set job="cook"
where employee_id="3";

update employees
set job="cook"
where employee_id="4";

update employees
set job="asst.manager"
where employee_id="5";

update employees
set job="janitor"
where employee_id="6";

select * from employees;

select * from employees
where hire_date between "2023-01-03" and "2023-01-05"; # both are inclusive

select * from employees
where hire_date = "2023-01-06";

select * from employees
where first_name ="patrick" and job="cook";

select * from employees
where first_name="patrick" or job="cook";

select * from employees
where first_name="patrick" or job !="cook";

select * from employees
where not job="manager";

select * from employees
where not job="manager" and not hourly_pay>15;

select * from employees
where not job="manager" and hourly_pay>15;

select * from employees
where not job="cook" or not hourly_pay>15;

select * from employees
where not job="cook" or hourly_pay>15;

select * from employees 
where job in ("asst.manager","cook");

select * from employees
where job in ("asst.manager","cook") and hourly_pay>15;

select * from employees;

# wild card characters are 1)% percentage, 2)_underscore
# we have 	like	 keyword to search a specific pattern usually with 		where 

select * from employees
where last_name like "%s"; # It considers last character.write character after % 

select * from employees
where first_name like"p%"; # It considers first character.write character before %

#If you have to search by third character

select * from employees
where first_name like "__t%"; # give two underscores first then character

select * from employees
where first_name like "__g%__e" and last_name like "%s";

select * from employees
where hire_date like "____-__-04";

select * from employees
where hourly_pay like "1%"; # It returns every value starts with 1

select * from employees
where hourly_pay like "%5"; # It returns every value ends with 5


select * from employees;

# ORDER BY


select * from employees
order by first_name;

select * from employees
order by last_name;

select * from employees
order by hourly_pay;

select * from employees
order by hourly_pay,first_name; 

select * from employees
order by first_name desc;

select * from employees
order by hire_date desc;

select * from employees
order by first_name desc,hourly_pay asc; # hourly_pay asc applies only when first_names are same

# LIMIT CLAUSE

select * from employees
limit 3;

select * from employees
order by last_name desc
limit 2;

# OFFSET

select * from employees
limit 2,1;	# HERE 2 IS AN OFFSET(NO OF ROWS TO SKIP) AND 1 IS NUMBER OF ROWS TO RETURN 

select * from employees
order by hourly_pay
limit 2,2;

select * from employees
order by hourly_pay desc
limit 3,1;


select * from employees;

select * from customers;

#union : selected columns should be equal

select  first_name,last_name from employees
union	# UNION DOESN'T CONSIDER DUPLICATE VALUES. IF NEEDED USE union all
select first_name,last_name from customers;

select employee_id,first_name,last_name from employees # here column names are employee_id,first_name,last_name
union
select customer_id, first_name,last_name from customers;

# Key Rule of UNION:
# The column names (headings) in the final result are always taken from the first SELECT statement.

select customer_id, first_name,last_name from customers # here column names are customer_id,first_name,last_name
union
select employee_id,first_name,last_name from employees;

# IF YOU WANT YOU CAN CHANGE THE COLUMN NAME

select employee_id as id,first_name,last_name from employees # HERE COLUMN NAMES ARE id,first_name,last_name
union
select customer_id, first_name,last_name from customers;

select * from customers;

alter table customers
add referral_id int;

update customers
set referral_id=1
where customer_id=2;

update customers
set referral_id=2
where customer_id=3;

update customers
set referral_id=2
where customer_id=4;

select * from customers;


# SELF JOIN: A SELF JOIN in MySQL is a regular join where a table is joined with itself.

select *
from customers as A
inner join customers as B
on A.referral_id= B.customer_id;

select A.customer_id, A.first_name, A.last_name,
concat(B.first_name," ",B.last_name)as "referred_by"
from customers as A
inner join customers as B	 
on A.referral_id= B.customer_id;


select A.customer_id, A.first_name, A.last_name,
concat(B.first_name," ",B.last_name)as "referred_by"
from customers as A
left join customers as B	
on A.referral_id= B.customer_id;

alter table employees
add column supervisor_id int; # here the word column is optional

set sql_safe_updates=0;

update employees
set supervisor_id=5
where employee_id=2;

update employees
set supervisor_id=5
where employee_id=3;

update employees
set supervisor_id=5
where employee_id=4;

update employees
set supervisor_id=5
where employee_id=6;

update employees
set supervisor_id=1
where employee_id=5;

select * from employees;

select a.first_name,a.last_name,	# Remaining columns are unncessary that's why we chose only necessary.
	concat(b.first_name," ",b.last_name) as "reports to"
    # we concat here because it looks good a combined name.
    from employees as a
    inner join employees as b
    on a.supervisor_id= b.employee_id;
    
    select a.first_name,a.last_name,	# Remaining columns are unncessary that's why we chose only necessary.
	concat(b.first_name," ",b.last_name) as "reports to"
    # we concat here because it looks good a combined name.
    from employees as a
    left join employees as b
    on a.supervisor_id= b.employee_id;


# views in mysql
#A View in MySQL is a virtual table based on the result of a SELECT query.
#It doesn't store data itself but shows data from one or more tables.

select * from employees;	# There are times where we need to work with few rows only then views help.

create view employee_attendance as
select first_name,last_name
from employees;

select * from employee_attendance;

select * from employee_attendance
order by last_name asc;

select * from employee_attendance
order by last_name desc;

drop view employee_attendance;

select * from customers;

    alter table customers
    add column email varchar(50);
    
    update customers
    set email="FFish@gmail.com"
    where customer_id=1;
    
	update customers
    set email="Llobster@gmail.com"
    where customer_id=2;
    
	update customers
    set email="Bbass@gmail.com"
    where customer_id=3;
    
	update customers
    set email="Ppuff@gmail.com"
    where customer_id=4;

select * from customers;

create view customer_emails as
select email
from customers;

select * from customer_emails;

insert into customers
values(5,"pearl","krabs",null,"PKrabs@gmail.com");

select * from  customers;

select * from customer_emails; # view also changes automatically if we add any rows into table 

# Index: It is used for searching. It allows duplicates
# create index: duplicates are allowed
#create unique index: duplicates are not allowed

select * from customers;

create index last_name_idx
on customers(last_name);

show indexes from customers;

# Multi column index

create index last_name_first_name_idx
on customers(last_name,first_name);

show indexes from customers;

alter table customers
drop index last_name_idx; # last_name_first_name_idx does both so we no need it.

#subquery: A query within another query
# It runs the inner query first, then uses its result in the outer query.

select * from employees;

select first_name,last_name,hourly_pay,
(select avg(hourly_pay) from employees) as avg_pay
from employees;

select first_name,last_name,hourly_pay,
(select max(hourly_pay) from employees) as max_pay  
from employees;

select hourly_pay from employees
order by hourly_pay desc
limit 1,1;	# It prints the second highest value. here first 1 represents offset second 1 represents limit

select distinct hourly_pay from employees
order by hourly_pay desc
limit 1 offset 1;

select max(hourly_pay) as second_max
from employees
where hourly_pay < (
select max(hourly_pay)
from employees
);

select min(hourly_pay) as second_min
from employees
where hourly_pay > (
select min(hourly_pay)
from employees
);

SELECT MIN(hourly_pay) AS third_smallest
FROM employees
WHERE hourly_pay > (
  SELECT MIN(hourly_pay)
  FROM employees
  WHERE hourly_pay > (
    SELECT MIN(hourly_pay)
    FROM employees
  )
);

select first_name,last_name,hourly_pay	#first read and do subquery then it feels easy.
from employees	
where hourly_pay > (select avg(hourly_pay)  from employees);

select * from employees;

select * from customers;

select first_name,last_name
from customers
where customer_id in
(select distinct customer_id
from transactions
where customer_id is not null);

select * from transactions;

# Group by: Aggregate all rows by a specified column often used with aggregate functions like sum(),max(),avg(),count()

insert into transactions(amount,customer_id)
values
(2.49,4);

insert into transactions(amount)
values
(5.48);

select * from transactions;

alter table transactions
add column order_date date;

update transactions
set order_date="2023-01-01"
where transaction_id =1000;

update transactions
set order_date="2023-01-01"
where transaction_id =1001;

update transactions
set order_date="2023-01-02"
where transaction_id =1002;

update transactions
set order_date="2023-01-02"
where transaction_id =1003;

update transactions
set order_date="2023-01-03"
where transaction_id =1004;

update transactions
set order_date="2023-01-03"
where transaction_id =1005;

update transactions
set order_date="2023-01-03"
where transaction_id =1006;

select * from transactions;

#group by

select sum(amount) ,order_date
from transactions
group by order_date;

select count(amount) ,order_date
from transactions
group by order_date;

select max(amount) ,order_date
from transactions
group by order_date;

select sum(amount), customer_id
from transactions
group by customer_id;

select count(amount), customer_id
from transactions
group by customer_id # we can't use where clause with group by
having count(amount) > 1 and customer_id is not null; # use having with group by clause

select * from transactions;

# ROLL UP: Extension of the group by clause
# Produces another row and shows the grand total (super aggregate value)

select sum(amount),order_date
from transactions
group by order_date with rollup;

select count(transaction_id) as num_of_orders,order_date
from transactions
group by order_date with rollup;

select * from employees;

select sum(hourly_pay) as total_amt_paid_in_onehour,employee_id
from employees
group by employee_id with rollup;

# on delete set null = when a fk is deleted, replace fk with null
# on delete cascade  = when a fk is deleted, delete row

CREATE TABLE departments (
  id INT PRIMARY KEY,
  name VARCHAR(50)
);

CREATE TABLE employees_null (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  dept_id INT,
  FOREIGN KEY (dept_id) REFERENCES departments(id)
    ON DELETE SET NULL
);

CREATE TABLE employees_cascade (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  dept_id INT,
  FOREIGN KEY (dept_id) REFERENCES departments(id)
    ON DELETE CASCADE
);

-- Departments
INSERT INTO departments VALUES (1, 'HR'), (2, 'IT');

-- Employees for SET NULL
INSERT INTO employees_null VALUES
  (101, 'Alice', 1),
  (102, 'Bob', 2);

-- Employees for CASCADE
INSERT INTO employees_cascade VALUES
  (201, 'Carol', 1),
  (202, 'David', 2);
  
  select * from departments;
  
  select * from employees_null;
  
  select * from employees_cascade;
  
  delete from departments where id=1;
  
  select * from transactions;
  
  select * from customers;
  
  delete from customers
  where customer_id=4; # can't delete or update a parent row. A foreign key constraint fails
  
# set foreign_key_checks=0; it works
# set foregin_key_checks=1; to come back into safe mode

set foreign_key_checks=0;

delete from customers
where customer_id=4; # Now it's deleted.

set foreign_key_checks=1;# Now we are back to safe mode.

select * from transactions;# Now we have transaction_id 1005 with references to customer_id

insert into customers
values
(4,"poppy","puff",2,"PPuff@gmail.com");

select * from customers;

alter table transactions
drop foreign key fk_customer_id;

alter table transactions
add constraint fk_customer_id
foreign key(customer_id) references customers(customer_id)
on delete set null;

delete from customers 
where customer_id=4;

select * from customers;

select * from transactions;

insert into customers
values(4,"poppy","puff",2,"PPuff@gmail.com");

select * from customers;

alter table transactions
drop foreign key fk_customer_id;

alter table transactions
add constraint fk_customer_id
foreign key(customer_id) references customers(customer_id)
on delete cascade;

select * from transactions;

delete from customers
where customer_id=4;

select * from customers;

# stored procedure: is prepared sql code that you can save. It is useful when you use same query often


delimiter $$
create procedure get_customers()
begin
	select * from customers;	#usually it stops here at semicolon to bypass it we add delimiter at beginning
end $$  # now u can see get_customers under stored procedures under schemas

delimiter ;# White space after delimiter is necessary.

call get_customers();# To invoke we call it

drop procedure get_customers;

delimiter $$
create procedure find_customer(in id int)
begin
	select * from customers
    where customer_id=id;
end$$

delimiter $$;

call find_customer(2);

call find_customer(4);

call find_customer(5);

drop procedure find_customer;


delimiter $$
create procedure find_customer(in f_name varchar(50),in l_name varchar(50))
begin
	select * from customers 
    where first_name = f_name and last_name=l_name;
end $$

delimiter ;

call find_customer("Larry","Lobster");




  
  
  
  
































