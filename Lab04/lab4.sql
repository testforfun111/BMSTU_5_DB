/*
	Создать, развернуть определяемую пользователем скалярную функцию CLR
	
	Вывести информацию о змеях с самым младшим возрастом
*/
create extension plpython3u;
create or replace function get_min_age_snake()
returns integer as
$$
	res = plpy.execute(f"select min(orderprice) as min_price\
		   from laptop.orders\
		   where status = 'Peding'");
	if res:
		return res[0]['min_price']
$$
language plpython3u;

select *
from laptop.orders
where status = 'Peding' and orderprice = get_min_age_snake();

SELECT * FROM pg_language;