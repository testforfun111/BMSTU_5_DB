
CREATE OR REPLACE FUNCTION totalRecords(varchar, integer, integer)
RETURNS varchar
as
$$
declare word alias for $1;
	startPos alias for $2;
	endPos alias for $3;
begin 
	return substring(word, startPos, endPos);
end;
$$
language plpgsql;
SELECT totalRecords('software', 5, 3);
