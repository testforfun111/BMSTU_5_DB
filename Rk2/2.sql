--Задание 2
--1.Указать все ID, название, год основание Санаторий, который есть год основание больше всех санаторий (есть название
--начинается из J)
SELECT sanatoriumid, sanatoriumname, sanatoriumyear
FROM rk2.sanatorium
WHERE sanatoriumyear > ALL ( SELECT sanatoriumyear
 FROM rk2.sanatorium
 WHERE sanatoriumname like 'J%' ) 

--2 указать название, год основание и 1 стобецы проверить is_year (это если год основание = 2001 то писать мой год
-- иначе писать другой год)
SELECT sanatoriumname, sanatoriumyear,
 CASE sanatoriumyear
 WHEN 2001 THEN 'мой год'
 ELSE 'Другой год'
 END AS is_year
FROM rk2.sanatorium
--3 удалить все строк есть regionname которая есть год основание санаторий < 2000
DELETE FROM rk2.regions
WHERE regionid IN ( SELECT temp_t.regionid
 FROM (rk2.regions as R JOIN rk2.sanatorium as S
 ON R.regionid = S.regionid) as temp_t
 WHERE temp_t.sanatoriumyear < 2000) 