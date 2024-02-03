DROP TABLE IF EXISTS test;
SELECT laptopmodel.modelname, orders.status, 
	ROW_NUMBER() OVER(PARTITION BY orders.status) AS Row_N
INTO test
FROM orders JOIN laptopmodel ON orders.modelid = laptopmodel.modelid;

DELETE FROM test
WHERE Row_N > 1;

select * from test; 