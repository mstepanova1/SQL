--1. Вывести все поля и все строки
select * from users;

--2. Вывести всех пользователей в таблице
select * from users;

--3. Вывести только ID пользователей
select user_id from users;

--4. Вывести только имя пользователей
select user_name from users;

--5. Вывести только email пользователей
select email from users;

--6. Вывести имя и email пользователей
select user_name, email from users;

--7. Вывести id, имя, email и дату создания пользователей
select user_id, user_name, email, creation_date from users;

--8. Вывести пользователей, где password 12333
select * from users 
where password = '12333';

--9. Вывести пользователей, которые были созданы 2022-03-26
select * from users 
where creation_date = '2022-03-26 00:00:00';

--10. Вывести пользователей, где в имени есть слово Anna
select * from users 
where user_name like '%Anna%';

--11. Вывести пользователей, где в имени в конце есть 8
select * from users 
where user_name like '%8';

--12. Вывести пользователей, где в имени есть буква а
select * from users 
where user_name like '%a%';

--13. Вывести пользователей, которые были созданы 2022-07-12
select * from users 
where creation_date = '2022-07-12 00:00:00';

--14. Вывести пользователей, которые были созданы 2022-07-12 и имеют пароль 1m313
select * from users 
where creation_date = '2022-07-12 00:00:00' 
and password = '1m313';

--15. Вывести пользователей, которые были созданы 2022-07-12 и у которых в имени есть слово Andrey
select * from users 
where creation_date = '2022-07-12 00:00:00' 
and user_name like '%Andrey%';

--16. Вывести пользователей, которые были созданы 2022-07-12 и у которых в имени есть цифра 8
select * from users 
where creation_date = '2022-07-12 00:00:00' 
and user_name like '%8%';

--17. Вывести пользователей, у которых id равен 10
select * from users 
where user_id = 10;

--18. Вывести пользователей, у которых id равен 53
select * from users 
where user_id = 53;

--19. Вывести пользователей, у которых id больше 40
select * from users 
where user_id > 40;

--20. Вывести пользователей, у которых id меньше 30
select * from users 
where user_id < 30;

--21. Вывести пользователей, у которых id меньше 27 или больше 88
select * from users 
where user_id < 27
or user_id > 88;

--22. Вывести пользователей, у которых id меньше, либо равно 37
select * from users 
where user_id <= 37;

--23. Вывести пользователей, у которых id больше, либо равно 37
select * from users 
where user_id >= 37;

--24. Вывести пользователей, у которых id больше 80, но меньше 90
select * from users 
where 80 < user_id < 90;

--25. Вывести пользователей, у которых id между 80 и 90
select * from users 
where user_id between 80 and 90;

--26. Вывести пользователей, где password равен 12333, 1m313, 123313
select * from users 
where password in ('12333', '1m313', '123313');

--27. Вывести пользователей, где creation_date равен 2021-10-03, 2022-05-19, 2023-03-26
select * from users 
where creation_date in ('2021-10-03 00:00:00', '2022-05-19 00:00:00', '2023-03-26 00:00:00');

--28. Вывести минимальный id
select min(user_id) from users;

--29. Вывести максимальный id
select max(user_id) from users;

--30. Вывести количество пользователей
select count(user_id) from users;

--31. Вывести id пользователя, имя, дату создания пользователя.
--Отсортировать по порядку возрастания даты добавления пользоватлеля.
select user_id, user_name, creation_date from users 
order by creation_date;

--32. Вывести id пользователя, имя, дату создания пользователя. 
--Отсортировать по порядку убывания даты добавления пользоватлеля.
select user_id, user_name, creation_date from users 
order by creation_date desc;