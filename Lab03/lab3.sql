--1.Скалярную функцию найти максимальная цена заказов, у которого в статусе "oтправленный"

CREATE OR REPLACE FUNCTION MAX_PRICE() RETURNS integer AS $$
begin
	return (select max(orderprice) from laptop.orders where status = 'Shipped');
end;
$$ LANGUAGE PLPGSQL;


SELECT MAX_PRICE();

--2. Подставляемую табличную функцию
-- найти все клиент с его адрессом, у которого заказ в статусе s

CREATE OR REPLACE FUNCTION FIND_CUSTOMER(S VARCHAR(20)) RETURNS TABLE(FIRSTNAME VARCHAR(50),

																																																																	ADDRESS VARCHAR(50)) AS $$
begin
	return query (select C.firstname, C.adress
			from laptop.customer C join laptop.orders O on C.customersid = O.customersid
			where O.status = s);
end;
$$ LANGUAGE PLPGSQL;


SELECT *
FROM FIND_CUSTOMER('Shipped');

--3. Многооператорную табличную функцию
--найти все клиент и его адресс, у которого есть цена заказ равна максильманая цена у всех статус s 
CREATE OR REPLACE FUNCTION TEST(s varchar(20))
RETURNS TABLE(FIRSTNAME VARCHAR(50), address varchar(50))
AS
$$
begin
	return query (select C.firstname, C.adress
			from laptop.customer C join laptop.orders O on C.customersid = O.customersid
			where O.orderprice = (select max(orderprice) from laptop.orders where status = s));
end;
$$
LANGUAGE plpgsql;

select * from test('Shipped');

--4 Рекурсивную функцию
--создать таблицу рекурсивой, в которой цена и количество заказов.
drop function rff(integer, integer);
create or replace function rff(price_start int, price_end int)
returns table (price int, cnt bigint)
language plpgsql
as $$
begin
    return query (select orderprice, count(*) from laptop.orders where orderprice = price_start group by orderprice);
    if price_start < price_end then
        return query select * from rff(price_start + 1, price_end);
    end if;
end $$;

select * from rff(100, 200);
--5 Хранимую процедуру с параметрами

CREATE OR REPLACE procedure max_price_pro() AS $$
begin
	 UPDATE laptop.orders
	set orderprice =  200
	where status = 'Pending';
end;
$$ LANGUAGE PLPGSQL;

call max_price_pro();

--6 Рекурсивную хранимую процедуру или хранимую процедур с рекурсивным ОТВ
create or replace procedure rffp(price_start int, price_end int)
language plpgsql
as $$
begin
    DELETE FROM laptop.orders
	where orderprice = price_start;
    if price_start < price_end then
        call rffp(price_start + 1, price_end);
    end if;
end $$;

call rffp(100, 102);

--7 Хранимую процедуру с курсором
-- изменять все цены заказов, у которого есть ид-клиент равно задано
create or replace procedure changeAge(cid integer, newPrice integer) as
$$
declare
	list record;
	kind_cursor cursor for
		select *
		from laptop.orders
		where customersid = cid;
begin
	open kind_cursor;
	loop
		fetch kind_cursor into list;
		exit when not found;
		update laptop.orders 
		set orderprice = newPrice
		where orderid = list.orderid;
	end loop;
	close kind_cursor;
end;
$$
language plpgsql;

call changeAge(1, 6);

--8 Хранимую процедуру доступа к метаданным
--вывести информацию об идентификаторе строки и используемой кодировки
create or replace procedure get_metadata(db_name text) as
$$
declare
	db_id int;
	db_encoding varchar;
begin
	select pg.oid, pg_encoding_to_char(pg.encoding) 
	from pg_database as pg
	where pg.datname = db_name
	
	into db_id, db_encoding;
	raise notice 'Database: %, DB_ID: %, DB_encoding: %', db_name, db_id, db_encoding;
end;
$$
language plpgsql;

call get_metadata('Laptop');

--9 Триггер AFTER
--вывести информацию при обновлении ...
create or replace function update_order()
returns trigger as
$$
begin 
	raise notice 'Old: %', old.orderprice;
	raise notice 'New: %', new.orderprice;
	return new;
end
$$
language plpgsql;

create or replace trigger update_order
after update on laptop.orders 
for each row
execute procedure update_order();
	
update laptop.orders 
set orderprice = 30
where status = 'Shipped';

select * from laptop.orders where status = 'Shipped';

--10 Триггер INSTEAD OF 
-- вместо удалить тогда выводить информации и заменить значение orderprice = 10.
drop view if exists order_view;
create view order_view
as select * from laptop.orders
where orderid < 10;

create or replace function delete_order()
returns trigger as
$$
begin
	raise notice 'ID: %.', old.orderid;
	
	update order_view 
	set orderprice = 10
	where orderid  = old.orderid;
	
	return new;
end;
$$
language plpgsql;

create or replace trigger delete_order
instead of delete on order_view
for each row
execute procedure delete_order();

delete from order_view
where orderid = 1;

select * from order_view
order by orderid;


--защит
drop function test(integer, integer);
create or replace function test(year_start integer, year_end integer)
returns table(Manu_Name varchar(20), CC varchar(20))
as
$$
begin
	return query (select manufacturername, country 
		   	from Laptop.manufacturer
		   where year_start < yearfounded and year_end > yearfounded);
end;
$$
language plpgsql;

select * from test(1900, 2000);