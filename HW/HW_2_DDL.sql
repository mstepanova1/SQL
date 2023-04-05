--1. Создать таблицу "employees"
create table employees (
	id serial primary key,
	employee_name varchar(50) not null
	);
	
--2. Наполнить таблицу "employee" 70 строками
insert into employees (id, employee_name) values 
		(default, 'Angelina Jolie'),
		(default, 'Charlize Theron'),
		(default, 'Jessica Alba'),
		(default, 'Megan Fox'),
		(default, 'Penelope Cruz'),
		(default, 'Robert Pattinson'),
		(default, 'Bradley Pitt'),
		(default, 'Antonio Banderas'),
		(default, 'David Boreanaz'),
		(default, 'George Clooney'),
		(default, 'Angelina Theron'),
		(default, 'Charlize Clooney'),
		(default, 'Jessica Fox'),
		(default, 'Megan Cruz'),
		(default, 'Penelope Boreanaz'),
		(default, 'Robert Pitt'),
		(default, 'Bradley Banderas'),
		(default, 'Antonio Theron'),
		(default, 'David Clooney'),
		(default, 'George Jolie'),
		(default, 'Angelina Fox'),
		(default, 'Charlize Alba'),
		(default, 'Jessica Cruz'),
		(default, 'Megan Pattinson'),
		(default, 'Penelope Pitt'),
		(default, 'Robert Banderas'),
		(default, 'Bradley Boreanaz'),
		(default, 'Antonio Clooney'),
		(default, 'David Jolie'),
		(default, 'George Clooney'),
		(default, 'Angelina Cruz'),
		(default, 'Charlize Pattinson'),
		(default, 'Jessica Pitt'),
		(default, 'Megan Banderas'),
		(default, 'Penelope Boreanaz'),
		(default, 'Robert Clooney'),
		(default, 'Bradley Jolie'),
		(default, 'Antonio Theron'),
		(default, 'David Alba'),
		(default, 'George Clooney'),
		(default, 'Angelina Pattinson'),
		(default, 'Charlize Pitt'),
		(default, 'Jessica Banderas'),
		(default, 'Megan Boreanaz'),
		(default, 'Penelope Clooney'),
		(default, 'Robert Jolie'),
		(default, 'Bradley Theron'),
		(default, 'Antonio Alba'),
		(default, 'David Fox'),
		(default, 'George Cruz'),
		(default, 'Angelina Pitt'),
		(default, 'Charlize Banderas'),
		(default, 'Jessica Boreanaz'),
		(default, 'Megan Clooney'),
		(default, 'Penelope Jolie'),
		(default, 'Robert Theron'),
		(default, 'Bradley Alba'),
		(default, 'Antonio Fox'),
		(default, 'David Cruz'),
		(default, 'George Pattinson'),
		(default, 'Angelina Banderas'),
		(default, 'Charlize Boreanaz'),
		(default, 'Jessica Clooney'),
		(default, 'Megan Alba'),
		(default, 'Penelope Theron'),
		(default, 'Robert Pitt'),
		(default, 'Bradley Clooney'),
		(default, 'Antonio Pattinson'),
		(default, 'David Cruz'),
		(default, 'George Fox');

--3. Создать таблицу "salary"
create table salary (
	id serial primary key,
	monthly_salary int not null
	);

--4. Наполнить таблицу "salary" 15 строками
insert into salary (id, monthly_salary) values
    (default, 1000),
    (default, 1100),
    (default, 1200),
    (default, 1300),
    (default, 1400),
    (default, 1500),
    (default, 1600),
    (default, 1700),
    (default, 1800),
    (default, 1900),
    (default, 2000),
    (default, 2100),
    (default, 2200),
    (default, 2300),
    (default, 2400),
    (default, 2500);

--5.	Создать таблицу "employee_salary"
create table employee_salary (
	id serial primary key,
	employee_id int not null unique,
	salary_id int not null
	);  
	
--6.	Наполнить таблицу "employee_salary" 40 строками.
--В 10 строк из 40 вставить несуществующие "employee_id"
insert into employee_salary (id, employee_id, salary_id) values
		(default, 3, 7),
		(default, 1, 4),
		(default, 5, 9),
		(default, 40, 13),
		(default, 23, 4),
		(default, 11, 2),
		(default, 52, 10),
		(default, 15, 13),
		(default, 26, 4),
		(default, 16, 1),
		(default, 33, 7),
		(default, 67, 16),
		(default, 4, 2),
		(default, 7, 6),
		(default, 8, 9),
		(default, 2, 13),
		(default, 37, 11),
		(default, 99, 1),
		(default, 68, 4),
		(default, 124, 8),
		(default, 43, 3),
		(default, 53, 7),
		(default, 57, 6),
		(default, 143, 13),
		(default, 133, 15),
		(default, 10, 11),
		(default, 6, 16),
		(default, 9, 8),
		(default, 150, 3),
		(default, 87, 13),
		(default, 95, 10),
		(default, 111, 3),
		(default, 88, 9),
		(default, 93, 7),
		(default, 132, 2),
		(default, 74, 5),
		(default, 48, 4),
		(default, 25,9),
		(default, 19,8),
		(default, 21,1);
		
--7.	Создать таблицу "roles"
create table roles (
	id serial primary key,
	role_name int not null unique
	);  
	
--8.	Поменять тип столба "role_name" с int на varchar(30)
alter table roles alter column role_name type varchar (30);

--9.	Наполнить таблицу "roles" 20 строками
insert into roles (id, role_name) values
    (default, 'Junior Python developer'),
    (default, 'Middle Python developer'),
    (default, 'Senior Python developer'),
    (default, 'Junior Java developer'),
    (default, 'Middle Java developer'),
    (default, 'Senior Java developer'),
    (default, 'Junior JavaScript developer'),
    (default, 'Middle JavaScript developer'),
    (default, 'Senior JavaScript developer'),
    (default, 'Junior Manual QA engineer'),
    (default, 'Middle Manual QA engineer'),
    (default, 'Senior Manual QA engineer'),
    (default, 'Project Manager'),
    (default, 'Designer'),
    (default, 'HR'),
    (default, 'CEO'),
    (default, 'Sales manager'),
    (default, 'Junior Automation QA engineer'),
    (default, 'Middle Automation QA engineer'),
    (default, 'Senior Automation QA engineer');
    
--10.	Создать таблицу "roles_employee"
create table roles_employee (
	id serial primary key,
	employee_id int not null unique,
	role_id int not null
	foreign key (employee_id)
		references employees (id),
	foreign key (role_id)
		references roles (id);
	);
	
--11.	Наполнить таблицу "roles_employee" 40 строками
insert into roles_employee (id, employee_id, role_id) values
		(default, 7, 2),
		(default, 20, 4),
		(default, 3, 9),
		(default, 5, 13),
		(default, 23, 4),
		(default, 11, 2),
		(default, 10, 9),
		(default, 22, 13),
		(default, 21, 3),
		(default, 34, 4),
		(default, 6, 7),
		(default, 29, 16),
		(default, 70, 2),
		(default, 1, 6),
		(default, 8, 9),
		(default, 19, 13),
		(default, 15, 11),
		(default, 51, 1),
		(default, 68, 4),
		(default, 9, 8),
		(default, 12, 3),
		(default, 33, 7),
		(default, 56, 6),
		(default, 4, 13),
		(default, 28, 15),
		(default, 41, 11),
		(default, 62, 16),
		(default, 49, 8),
		(default, 55, 3),
		(default, 17, 13),
		(default, 27, 10),
		(default, 43, 3),
		(default, 58, 9),
		(default, 54, 7),
		(default, 32, 2),
		(default, 63, 5),
		(default, 38, 4),
		(default, 35,9),
		(default, 42,8),
		(default, 13,1);

--12. Создать недостающие связи между таблицами
alter table employee_salary 
add foreign key (salary_id)
		references salary (id);