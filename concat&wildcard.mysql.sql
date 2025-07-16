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







