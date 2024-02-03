drop table col;
create table col(value int);

insert into col(value)
values (1), (2), (3), (4), (5), (6), (7), (8);

SELECT A.value, B.value, C.value, D.value, E.value, F.value, G.value, H.value
	FROM col AS A, col AS B, col AS C, col AS D, col AS E, col AS F, col AS G, col AS H
	WHERE 
    	A.value NOT IN (B.value, C.value, D.value, E.value, F.value, G.value, H.value, B.value+1, C.value+2, D.value+3, E.value+4, F.value+5, G.value+6, H.value+7, B.value-1, C.value-2, D.value-3, E.value-4, F.value-5, G.value-6, H.value-7)
  		AND B.value NOT IN (C.value, D.value, E.value, F.value, G.value, H.value, C.value+1, D.value+2, E.value+3, F.value+4, G.value+5, H.value+6, C.value-1, D.value-2, E.value-3, F.value-4, G.value-5, H.value-6)
  		AND C.value NOT IN (D.value, E.value, F.value, G.value, H.value, D.value+1, E.value+2, F.value+3, G.value+4, H.value+5, D.value-1, E.value-2, F.value-3, G.value-4, H.value-5)
  		AND D.value NOT IN (E.value, F.value, G.value, H.value, E.value+1, F.value+2, G.value+3, H.value+4, E.value-1, F.value-2, G.value-3, H.value-4)
  		AND E.value NOT IN (F.value, G.value, H.value, F.value+1, G.value+2, H.value+3, F.value-1, G.value-2, H.value-3)
  		AND F.value NOT IN (G.value, H.value, G.value+1, H.value+2, G.value-1, H.value-2)
  		AND G.value NOT IN (H.value, H.value+1, H.value-1);