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














