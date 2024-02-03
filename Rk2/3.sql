--задание 3

CREATE OR REPLACE FUNCTION find_scalar_functions(prefix text)
RETURNS INT AS $$
DECLARE
    function_name text;
    function_count INT := 0;
BEGIN
    FOR function_name IN (SELECT routine_name
                          FROM information_schema.routines
                          WHERE routine_type = 'FUNCTION'
                          AND routine_schema = current_schema()
                          AND routine_name LIKE prefix || '%') 
    LOOP
        -- Выводим текст функции
        RAISE NOTICE 'Текст функции %:', function_name;
        EXECUTE 'SELECT pg_get_functiondef(' || quote_literal(function_name) || ')';
        function_count := function_count + 1;
    END LOOP;
    RETURN function_count;
END;
$$ LANGUAGE plpgsql;

select find_scalar_functions('m');