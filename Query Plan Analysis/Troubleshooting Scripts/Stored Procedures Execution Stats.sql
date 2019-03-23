SELECT TOP (25) 
	 p.NAME AS [SP Name]
	,qs.execution_count
	,qs.cached_time
	-- Elapsed Time
	,qs.min_elapsed_time / cast(1000000 AS FLOAT) AS [min_elapsed_time_seconds]
	,qs.max_elapsed_time / cast(1000000 AS FLOAT) AS [max_elapsed_time_seconds]
	,qs.last_elapsed_time / cast(1000000 AS FLOAT) AS [last_elapsed_time_seconds]
	,qs.total_elapsed_time / cast(1000000 AS FLOAT) AS [total_elapsed_time_seconds]
	,qs.total_elapsed_time / qs.execution_count / cast(1000000 AS FLOAT) AS [avg_elapsed_time_seconds]
	-- Worker Time
	,qs.min_worker_time / cast(1000000 AS FLOAT) AS [min_worker_time_seconds]
	,qs.max_worker_time / cast(1000000 AS FLOAT) AS [max_worker_time_seconds]
	,qs.last_worker_time / cast(1000000 AS FLOAT) AS [last_worker_time_seconds]
	,qs.total_worker_time / cast(1000000 AS FLOAT) AS [total_worker_time_seconds]
	,qs.total_worker_time / qs.execution_count / cast(1000000 AS FLOAT) AS [avg_worker_time_seconds]
	-- Logical Reads
	,qs.min_logical_reads
	,qs.max_logical_reads
	,qs.last_logical_reads
	,qs.total_logical_reads
	,qs.total_logical_reads / qs.execution_count as [avg_logical_reads]
	-- Physical Reads
	,qs.min_physical_reads
	,qs.max_physical_reads
	,qs.last_physical_reads
	,qs.total_physical_reads
	,qs.total_physical_reads / qs.execution_count as [avg_physical_reads]
	-- Logical Writes
	,qs.min_logical_writes
	,qs.max_logical_writes
	,qs.last_logical_writes
	,qs.total_logical_writes
	,qs.total_logical_writes / qs.execution_count as [avg_logical_writes]
	-- AVG IO
	,(qs.total_logical_reads + qs.total_logical_writes) / qs.execution_count AS [Avg IO]
	,qs.plan_handle
FROM sys.procedures AS p WITH (NOLOCK)
INNER JOIN sys.dm_exec_procedure_stats AS qs WITH (NOLOCK) ON p.object_id = qs.object_id
WHERE qs.database_id = DB_ID()
ORDER BY [avg_elapsed_time_seconds] DESC
--ORDER BY qs.execution_count DESC
OPTION (RECOMPILE);


/*
select * from  sys.dm_exec_query_plan (0x05000900784D9104105771230100000001000000000000000000000000000000000000000000000000000000)
*/
