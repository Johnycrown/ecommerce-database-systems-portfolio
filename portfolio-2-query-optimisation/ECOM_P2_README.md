# Portfolio 2 — SQL Querying and Optimisation

This portfolio demonstrates advanced SQL operations
and database performance optimisation.

The queries include:
- Multi-table joins.
- Aggregate functions.
- Common Table Expressions (CTEs).
- Window functions.
- JSONB searches.
- Index optimisation.
- EXPLAIN ANALYZE.

## Query optimisation experiment

The experiment compares a query execution plan before
and after creating a composite index.

The index is:

(order_status, created_at DESC)

EXPLAIN ANALYZE and BUFFERS are used to inspect:
- Execution time.
- Query plan nodes.
- Estimated and actual rows.
- Buffer reads and hits.

An index does not always improve performance.
For small tables, PostgreSQL may prefer a sequential
scan because it is cheaper.