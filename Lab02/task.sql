-- 1. найти все клиенты, у которых есть цена заказы больше 100 и адресс начинается с А. (сортировать по первое имя)
SELECT DISTINCT C1.firstname, C1.email
FROM laptop.Customer C1 JOIN laptop.orders AS C2 ON C1.customersid = C2.customersid
WHERE C2.orderprice > 100 AND C1.Adress like 'A%'
ORDER BY C1.firstname
--2. найти всё заказы, у которых есть цена от 1 до 100 
SELECT DISTINCT orderid, OrderDate
FROM laptop.Orders
WHERE orderprice between 1 and 100
--3  Указать первое имя, день заказа покупателя, у которого последное имя начинает из А
SELECT DISTINCT C1.firstname, C2.orderdate
FROM laptop.Customer C1 join laptop.orders as c2 on c1.customersid = c2.customersid
where c1.lastname like 'A%'
--4  Получить список заказ ИД, покупатель ИД, день заказа для клиент из адресса начинается из А
SELECT status, OrderDate
FROM laptop.Orders
WHERE CustomersID IN (SELECT CustomersID
	FROM laptop.Customer
	WHERE Adress like 'A%') 
--5 Получить список модельИД, modelname у которых есть цена меньше 200
SELECT ModelId, modelname
FROM laptop.Laptopmodel
WHERE EXISTS (SELECT laptopmodel.modelid
 FROM laptop.Laptopmodel LEFT OUTER JOIN laptop.orders ON laptop.laptopmodel.modelid = laptop.orders.modelid
 WHERE laptop.orders.orderprice < 200
)  
--6 Получить список заказИД, статус заказа, день заказа, цена, у которых цена больше всех цена у заказов есть статус "в ожидание"
SELECT orderid, status, orderdate, orderprice
FROM laptop.orders
WHERE orderprice > ALL ( SELECT orderprice
 FROM laptop.orders
 WHERE status = 'Pending' )
--7 Вычислить сумму цены все заказов по статус
SELECT status, sum(orderprice) AS Prices
 FROM laptop.orders
 GROUP BY status 
--8 получить таблицу orderid, orderdate, avg price, у которого status является ожидания.
SELECT orderid, orderdate,
 ( SELECT AVG(price)
 FROM laptop.laptopmodel
 WHERE laptop.laptopmodel.modelid = laptop.orders.modelid) AS AvgPrice
FROM laptop.orders
WHERE status = 'Pending'
--9 получить список клиент, и заказ, у которых цена больше 100 и статус по русски
SELECT firstname, Adress, OrderID, orderdate,
 CASE status
 WHEN 'Pending' THEN 'Ожидание'
 WHEN 'shipped' THEN 'отправленный'
 WHEN 'refunded' THEN 'возвращен'
 ELSE 'обработка'
END AS статус
FROM laptop.Orders JOIN laptop.Customer ON laptop.Orders.CustomersID = laptop.Customer.CustomersID
where orderprice > 100
--10 получить список заказ
SELECT orderid, status, orderdate,
 CASE
 WHEN extract('Year' from orderdate) < 2000 THEN 'XX'
 WHEN extract('Year' from orderdate) >= 2000 THEN 'XXI'
 END AS century
FROM laptop.orders 
order by century desc
--11 Создание новой временной локальной таблицы
drop table if exists aaa CASCADE;
SELECT status, SUM(orderprice) AS SQ
INTO aaa
FROM laptop.Orders 
WHERE laptop.orders.orderprice > 500
GROUP BY status;

select * from aaa
--12 найти все клиеты, у которых статус заказы Ожидание.
SELECT Firstname, lastname, prices
FROM laptop.customer C1 JOIN ( SELECT customersid, orderprice AS prices
 FROM laptop.orders where status = 'Pending'
) AS OD ON C1.customersid = OD.customersid

--13 найти все клиенты, у которых есть сумма цена заказы больше всего.
select firstname, lastname
from laptop.customer as C join (select customersid
	from laptop.orders
	group by customersid
	having sum(orderprice) = (select max(tt) from (select sum(orderprice) as tt
							from laptop.orders
							group by customersid))) as O on C.customersid = O.customersid
							
--14 Посчитать количество заказ по статусам
SELECT status, count(*) as cnt
FROM laptop.orders 
GROUP BY status

--15 Посчитать количество заказ по статусам и средная цена больше средняя цена всех заказов.
SELECT status, count(*) as cnt, avg(orderprice)
FROM laptop.orders 
GROUP BY status
HAVING AVG(orderprice) > ( SELECT AVG(orderprice) AS MPrice
 FROM laptop.orders) 
 
--16 вставка значение в таблицу
INSERT INTO laptop.orders (customersid, modelid, manufacturerid, orderdate, orderprice, status)
VALUES (11, 11, 22, '1999-01-22', 232, 'Pending') 

--17 Многострочная инструкция INSERT, выполняющая вставку в таблицу
-- результирующего набора данных вложенного подзапроса
INSERT INTO laptop.orders (customersid, modelid, manufacturerid, orderdate, orderprice, status)
select customersid, 100, 100, orderdate, orderprice, 'Pending'
FROM laptop.orders
WHERE orderprice > 100 and orderprice < 150
--18 update price = 200 ìf status = 'pending'
UPDATE laptop.orders
set orderprice =  200
where status = 'Pending'
--19 Инструкция UPDATE со скалярным подзапросом в предложении SET
UPDATE laptop.orders
SET orderprice = ( SELECT avg(orderprice)
 FROM laptop.orders
 WHERE status = 'Pending' )
WHERE status = 'Pending' 
--20
DELETE FROM laptop.orders
where orderid <= 2
--21 удалить всё заказы в ожидание.
DELETE FROM laptop.orders
WHERE orderid IN ( SELECT laptop.orders.orderid
 FROM laptop.orders LEFT OUTER JOIN laptop.customer
 ON laptop.orders.orderid = laptop.customer.customersid
 WHERE laptop.orders.status = 'Pending') 
 
--22 Инструкция SELECT, использующая простое обобщенное табличное выражение
with tempp(customersid, status, avg_price) as 
( select customersid, status, avg(orderprice) 
		from laptop.orders 
		group by status, customersid)
select * from tempp;

--23 рекусривно найти заказ сначало из у клиентИд (есть цена заказ = 100) до клиентИД 1000.
WITH RECURSIVE RecursiveTable(orderid, status, orderprice, numbers) AS (
    SELECT O.orderid, O.status, O.orderprice, O.customersid AS numbers
    FROM laptop.orders AS O
    WHERE O.orderprice = 100
    UNION ALL
    SELECT O.orderid, O.status, O.orderprice, O.customersid + 1
    FROM laptop.orders AS O
    JOIN RecursiveTable ON O.customersid = RecursiveTable.numbers
	where numbers < 1000
)
SELECT * FROM RecursiveTable;

--24 создать таблицу заказов (orderid, orderprice, средняя цена по статус)
select orderid, orderprice, status, avg(orderprice) over(partition by status) as avg_col
from laptop.orders
where orderprice < 100
--25 Ранжировать заказ по цене в статусе.
select orderid, orderprice, status, rank() over(partition by status order by orderprice) as avg_col
from laptop.orders
where orderprice < 100 

