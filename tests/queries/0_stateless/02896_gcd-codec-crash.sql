DROP TABLE IF EXISTS test;

CREATE TABLE test (a Nullable(Int64) CODEC (GCD,LZ4)) ENGINE=MergeTree Order by ();
INSERT INTO test SELECT 0 FROM numbers(1e2);
SELECT * FROM test FORMAT Null;

DROP TABLE IF EXISTS test;