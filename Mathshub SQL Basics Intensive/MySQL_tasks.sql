-- 1. НАЙТИ МАКСИМАЛЬНУЮ И МИНИМАЛЬНУЮ ЦЕНУ ТОВАРА

select min(PRICE), max(PRICE) 
from shop.vendorcode 
;
-- 2. ВЫВЕСТИ ТОП 3 САМЫХ ДЕШЕВЫХ ТОВАРА (ИЛИ КАТЕГОРИИ ТОВАРА)

select avg(PRICE) as 'AVERAGE PRICE', PRODUCTCATEGORY  
from shop.vendorcode
group by PRODUCTCATEGORY 
order by avg(PRICE) 
limit 3
;
-- 3. НАЙТИ ТОВАРЫ, КОТОРЫЕ ПОКУПАЛИСЬ БОЛЕЕ 2-Х РАЗ

select VENDORCODE, count(*)
from shop.purchase 
group by VENDORCODE 
having count(*)>2
;
-- 4. КАКОЙ ТОВАР КУПИЛИ ПОСЛЕДНИМ?

select *
from shop.purchase
order by PURDATE desc
limit 1
;
-- 5. СКОЛЬКО ВСЕГО ПОКУПОК БЫЛО? А СКОЛЬКО БЫЛО КУПЛЕНО УНИКАЛЬНЫХ ТОВАРОВ?

select count(VENDORCODE), count(distinct VENDORCODE)
from shop.purchase
;
-- 6. ТОВАРОВ КАКОЙ КАТЕГОРИИ НАХОДИТСЯ БОЛЬШЕ 100 ШТУК?

select PRODUCTCATEGORY, sum(AMOUNT)
from shop.vendorcode
group by PRODUCTCATEGORY 
having sum(AMOUNT)>100
;
-- 7. КАКИЕ ТОВАРЫ ПОЛЬЗУЮТСЯ ПОПУЛЯРНОСТЬЮ У ПОКУПАТЕЛЕЙ? ВЫВЕДИТЕ СПИСОК ТОВАРОВ. ВЫВЕДИТЕ СПИСОК ПОПУЛЯРНЫХ КАТЕГОРИЙ С НАЗВАНИЯМИ.

select t.TYPENAME, count(*)
from shop.purchase p 
left join shop.vendorcode v on 1=1
and p.VENDORCODE = v.VENDORCODE 
join shop.category c on 1=1
and v.PRODUCTCATEGORY = c.CATEGORYID 
join shop.`type` t on 1=1
and v.PRODUCTTYPE = t.TYPEID 
group by t.TYPENAME 
order by count(*) desc 
;
select c.CATEGORYNAME, count(*)
from shop.purchase p 
left join shop.vendorcode v on 1=1
and p.VENDORCODE = v.VENDORCODE 
join shop.category c on 1=1
and v.PRODUCTCATEGORY = c.CATEGORYID 
join shop.`type` t on 1=1
and v.PRODUCTTYPE = t.TYPEID 
group by c.CATEGORYNAME
order by count(*) desc 
;
-- 8. ВЫВЕСТИ СРЕДНЮЮ ЦЕНУ ПОКУПОК С УЧЕТОМ СКИДОК

select round(avg(v.PRICE*(100-coalesce(c.DISCOUNT,0))/100*p.AMOUNT),0) as 'AVERAGE COST'
from shop.purchase p  
join shop.customer c2 on 1=1
and p.ID = c2.id 
join shop.vendorcode v on 1=1
and p.VENDORCODE = v.VENDORCODE 
join shop.category c on 1=1
and v.PRODUCTCATEGORY = c.CATEGORYID 
;
-- 9. ВЫВЕСТИ СПИСОК ПОКУПАТЕЛЕЙ И ИХ ЛЮБИМЫЕ ПРОДУКТЫ

select c.CUSTOMERNAME, t.TYPENAME 
from shop.purchase p 
join shop.customer c on 1=1
and p.ID = c.id 
join shop.vendorcode v on 1=1
and p.VENDORCODE = v.VENDORCODE 
join shop.`type` t on 1=1
and v.PRODUCTTYPE = t.TYPEID 
;
-- 10. ОПРЕДЕЛИТЬ, КАКИЕ КАТЕГОРИИ ПРОДУКТОВ ПОПУЛЯРНЫ У МУЖЧИН, А КАКИЕ У ЖЕНЩИН

select c2.CATEGORYNAME, c.GENDER, count(c.GENDER) 
from shop.purchase p 
join shop.customer c on 1=1
and p.ID = c.id 
join shop.vendorcode v on 1=1
and p.VENDORCODE = v.VENDORCODE 
join shop.category c2 on 1=1
and v.PRODUCTCATEGORY = c2.CATEGORYID 
group by c2.CATEGORYNAME, c.GENDER 
;
-- 11. ВЫВЕДИТЕ АРТИКУЛ И ДАТУ ПЕРВОЙ И ПОСЛЕДНЕЙ ПОКУПКИ

(select *
from shop.purchase 
order by PURDATE 
limit 1)
union all
(select *
from shop.purchase 
order by PURDATE desc
limit 1)
;
-- 12. НАЙДИТЕ ТОП 3 САМЫХ ДОРОГИХ ТОВАРА, А ЗАТЕМ ПОСЧИТАЙТЕ КОЛИЧЕСТВО ТОВАРОВ, ЦЕНА КОТОРЫХ БОЛЕЕ 142 

select sum(a.AMOUNT) as 'TOTAL AMOUNT'
from (
		select *
		from shop.vendorcode 
		order by PRICE desc 
		limit 3
) a
where a.PRICE>142
;
-- 13. НАЙДИТЕ ТОВАРЫ, КОТОРЫЕ БЫЛИ КУПЛЕНЫ МУЖЧИНАМИ

select c.CATEGORYNAME, t.TYPENAME 
from shop.purchase p 
join shop.vendorcode v on 1=1
and p.VENDORCODE = v.VENDORCODE 
join shop.category c on 1=1
and v.PRODUCTCATEGORY = c.CATEGORYID 
join shop.`type` t on 1=1
and v.PRODUCTTYPE = t.TYPEID 
where p.ID not in (select c2.id
from shop.customer c2  
where c2.GENDER = 'M')
;
-- 14. СОЗДАЙТЕ СТЕ, В КОТОРОЙ БУДУТ ТОЛЬКО ПОКУПКИ, СОВЕРШЕННЫЕ ЖЕНЩИНАМИ

with table_1 as (
select p.*
from shop.purchase p 
join shop.vendorcode v on 1=1
and p.VENDORCODE = v.VENDORCODE 
join shop.category c on 1=1
and v.PRODUCTCATEGORY = c.CATEGORYID 
join shop.`type` t on 1=1
and v.PRODUCTTYPE = t.TYPEID 
where p.ID in (select c2.id
from shop.customer c2  
where c2.GENDER = 'F')
),

table_2 as (
select *
from shop.category c 
)

select *
from table_2
;
-- 15. РЕШИТЕ ЗАДАЧУ, ИСПОЛЬЗУЯ SELECT В SELECT: ВЫВЕДИТЕ ИЗ ТАБЛИЦЫ С АРТИКУЛАМИ ТОЛЬКО ТЕ ДАННЫЕ, АРТИКУЛЫ КОТОРЫХ ЕСТЬ В ТАБЛИЦЕ ПОКУПОК

select *
from shop.vendorcode v 
where v.VENDORCODE in (select distinct p.VENDORCODE 
from shop.purchase p)
;
-- 16. РЕШИТЕ ЗАДАЧУ ПРИ ПОМОЩИ UNION: ВЫВЕДИТЕ СПИСОК ПОКУПОК ЖЕНЩИН И ОБЪЕДИНИТЕ ЕГО СО СПИСОКОМ ПОКУПОК МУЖЧИН

select *
from shop.purchase p 
where p.ID in (select c.id 
from shop.customer c 
where c.GENDER = 'F')
union
select *
from shop.purchase p 
where p.ID in (select c.id 
from shop.customer c 
where c.GENDER = 'M')
;
-- 17. СОЗДАЙТЕ СТЕ, В КОТОРОЙ БУДЕТ ПОСЧИТАНА СТОИМОСТЬ ТОВАРОВ С УЧЕТОМ СКИДКИ, А В ОСНОВНОМ ЗАПРОСЕ ВЫВЕДИТЕ ТОЛЬКО ТЕ СТРОКИ, ГДЕ ИТОГОВАЯ СТОИМОСТЬ БОЛЬШЕ 100 РУБЛЕЙ

with list_1 as (select v.VENDORCODE, v.PRICE*(100-coalesce(c.DISCOUNT,0))/100 as 'NEW_PRICE' 
from shop.vendorcode v 
join shop.category c on 1=1
and v.PRODUCTCATEGORY = c.CATEGORYID)

select *
from list_1
where NEW_PRICE>100
;
-- 18. ВЫВЕСТИ САМЫЙ ДОРОГОЙ ПРОДУКТ В СВОЕЙ КАТЕГОРИИ

with list_1 as (select v.VENDORCODE, v.PRICE, c.CATEGORYNAME, v.PRODUCTCATEGORY  
from shop.vendorcode v 
join shop.category c on 1=1
and v.PRODUCTCATEGORY = c.CATEGORYID),

list_2 as (select max(PRICE) as 'PRICE', PRODUCTCATEGORY
from list_1 l
group by PRODUCTCATEGORY)

select v.VENDORCODE
from list_2 l
join shop.vendorcode v on 1=1 
and l.PRICE=v.PRICE 
and l.PRODUCTCATEGORY=v.PRODUCTCATEGORY 
;
-- 19. ДАТЬ НАЗВАНИЙ КАТЕГОРИЙ КУПЛЕННЫХ ТОВАРОВ НА РУССКОМ

select *,
		case
				when CATEGORYNAME = 'DAIRY' then 'МОЛОЧНЫЕ ПРОДУКТЫ'
				when CATEGORYNAME = 'FRUIT' then 'ФРУКТЫ'
				when CATEGORYNAME = 'BAKERY PRODUCTS' then 'ВЫПЕЧКА'
				when CATEGORYNAME = 'VEGETABLES' then 'ОВОЩИ'	
				when CATEGORYNAME = 'DRINKS' then 'НАПИТКИ'	
				when CATEGORYNAME = 'SAUCES' then 'СОУСЫ'
				when CATEGORYNAME = 'SPICES' then 'СПЕЦИИ'
				when CATEGORYNAME = 'MEAT' then 'МЯСО'
				when CATEGORYNAME = 'FISH' then 'РЫБА'
				when CATEGORYNAME = 'CEREALS' then 'ЗЕЛЕНЬ'
				when CATEGORYNAME = 'DESSERTS' then 'ДЕСЕРТЫ'
		end 'RESULT'
from shop.category 
;
-- 20. РАЗДЕЛИТЬ ТОВАРЫ ПО ЦЕНЕ НА ТРИ КАТЕГОРИИ : ДО 100 – ДЕШЕВЫЕ, ОТ 100 ДО 120 – СРЕДНИЕ, БОЛЕЕ 120 - ДОРОГИЕ

select *,
		case when PRICE<100 then 'ДЕШЕВЫЕ'
				when PRICE>=100 and PRICE<=120 then 'СРЕДНИЕ'
				else 'ДОРОГИЕ'
		end 'PRICE_TYPE'
from shop.vendorcode
;
-- 21. ПОСЧИТАТЬ СТОИМОСТЬ ВСЕХ ТОВАРОВ ПО НОВЫМ КАТЕГОРИЯМ (ДЕШЕВЫЕ, СРЕДНИЕ, ДОРОГИЕ)

with list_1 as (select *,
		case when PRICE<100 then 'ДЕШЕВЫЕ'
				when PRICE>=100 and PRICE<=120 then 'СРЕДНИЕ'
				else 'ДОРОГИЕ'
		end 'PRICE_TYPE'
from shop.vendorcode)

select PRICE_TYPE, sum(PRICE)
from list_1
group by PRICE_TYPE
;
-- 22. ВСЕМ ТОВАРАМ, У КОТОРЫХ НЕТ СКИДКИ – ДОБАВИТЬ СКИДКУ 2%

select *,
		case when DISCOUNT is null then '2'
		when DISCOUNT is not null then DISCOUNT end 'DISCOUNT_NEW'
from shop.category
;
-- 23. ВЫВЕСТИ СПИСОК ПРОДУКОВ, КОТОРЫЕ НЕ ПОКУПАЛИ

select v.VENDORCODE as 'VENDORCODE', p.VENDORCODE as 'PURCHASE'
from shop.vendorcode v 
left join shop.purchase p on 1=1
and v.VENDORCODE = p.VENDORCODE 
where p.VENDORCODE is null
;
-- 24. ВЫВЕДИТЕ ИЗ ТАБЛИЦЫ С АРТИКУЛАМИ ДАННЫЕ, УКАЗАВ В ДОПОЛНИТЕЛЬНОМ СТОЛЦЕ – БЫЛИ ЛИ КУПЛЕНЫ ЭТИ ТОВАРЫ МУЖЧИНАМИ ИЛИ НЕТ

select v.*,
		case when c.GENDER = 'M' then 'Куплен мужчиной' 
			else 'нет' 
		end 'Gender_purchase'
from shop.vendorcode v 
left join shop.purchase p on 1=1
and v.VENDORCODE = p.VENDORCODE 
left join shop.customer c on 1=1
and p.ID = c.id 
;
-- 25. СОЗДАЙТЕ СТЕ, В КОТОРОЙ БУДЕТ ПОСЧИТАНА СТОИМОСТЬ ТОВАРОВ С УЧЕТОМ СКИДКИ, У ТЕХ ТОВАРОВ, У КОТОРЫХ СКИДКИ НЕТ – ПРИМЕНИТЕ К СТОИМОСТИ КУПОН НА 20. 
-- В ОСНОВНОМ ЗАПРОСЕ ВЫВЕДИТЕ ТОЛЬКО ТЕ СТРОКИ, ГДЕ ИТОГОВАЯ СТОИМОСТЬ БОЛЬШЕ 90

with list_1 as (select v.VENDORCODE, v.PRICE, coalesce(c.DISCOUNT,0) as 'DISCOUNT',
		case when coalesce(c.DISCOUNT,0)>0 then v.PRICE*(100-coalesce(c.DISCOUNT,0))/100 
			else v.PRICE-20 
		end 'NEW_PRICE'
from shop.vendorcode v 
join shop.category c on 1=1
and v.PRODUCTCATEGORY = c.CATEGORYID) 

select *
from list_1
;
-- 26. ВЫВЕСТИ САМЫЙ ДОРОГОЙ ПРОДУКТ В СВОЕЙ КАТЕГОРИИ

select v.PRICE, v.PRODUCTCATEGORY 
from shop.vendorcode v 
where v.PRICE=(select max(v2.PRICE) 
	from shop.vendorcode v2 
	where v.PRODUCTCATEGORY = v2.PRODUCTCATEGORY)
;
-- 27. ВЫВЕДИТЕ ИМЕНА ПОКУПАТЕЛЕЙ В НИЖНЕМ И ВЕРХНЕМ РЕГИСТРЕ

select CUSTOMERNAME, upper(CUSTOMERNAME), lower(CUSTOMERNAME)  
from shop.customer
;
-- 28. ВЫВЕДИТЕ ИМЯ ПОКУПАТЕЛЯ В ФОРМАТЕ «И. ФАМИЛИЯ»

select CUSTOMERNAME,
left(CUSTOMERNAME,1) as 'INITIALS',
instr(CUSTOMERNAME,' ') as 'Pro',
length(CUSTOMERNAME),
length(CUSTOMERNAME)-instr(CUSTOMERNAME,' ') as 'Eur',
right(CUSTOMERNAME, length(CUSTOMERNAME)-instr(CUSTOMERNAME,' ')) as 'SURNAME',
concat(left(CUSTOMERNAME,1), '. ', right(CUSTOMERNAME, length(CUSTOMERNAME)-instr(CUSTOMERNAME,' '))) as 'FULL_NAME' 
from shop.customer
;
-- 29. ВЫВЕДИТЕ В ОТДЕЛЬНОМ СТОЛБЦЕ ИНФОРМАЦИЮ ОТ ТОМ, ЧЕТНЫЙ ЛИ ЭТО МЕСЯЦ

select *, month(PURDATE) as 'MONTH',
		case when month(PURDATE)%2=0 then 'even' 
			else 'odd' 
		end 'OST'
from shop.purchase
;
-- 30. В КАКОМ ГОДУ БЫЛО БОЛЬШЕ ВСЕГО ПОКУПОК?

select count(*), year(PURDATE) as 'YEAR'
from shop.purchase
group by year(PURDATE)
order by count(*) desc
limit 1
;
-- 31. НАЙТИ АРТИКУЛЫ, КОТОРЫЕ ПОКУПАЛИСЬ ЗА 2 ГОДА ДО ПОСЛЕДНЕЙ ПОКУПКИ АРТИКУЛА 264723

with list_1 as (select PURDATE as 'DATE_PURCHASE'
from shop.purchase
where VENDORCODE='264723'
order by PURDATE desc
limit 1)

select *
from shop.purchase
where PURDATE>=(select date_add(DATE_PURCHASE, interval -2 year) 
	from list_1) 
and PURDATE<(select DATE_PURCHASE 
	from list_1)
;
