
**File:** `FinalSummary.md`

```markdown
# ShopSphere Technologies
## MIT 8103 — Advanced Database Systems Portfolio

**Student Name:Oladeji John

**Matriculation Number:** [Your Matric Number]

**Case Study:** ShopSphere Technologies — Nigerian
Multi-Vendor E-commerce Platform

## 1. Introduction

ShopSphere Technologies is a simulated Nigerian
e-commerce platform that connects customers with
multiple vendors.

The platform supports customer registration, product
catalogue management, shopping carts, inventory,
orders, payments, delivery tracking and reviews.

The project demonstrates the application of
relational and NoSQL database technologies to
different business workloads.

The proposed architecture uses PostgreSQL as the
primary transactional database, MongoDB for flexible
product catalogue storage and Redis for caching
and shopping cart operations.

## 2. Portfolio 1 — Relational Database Design

The relational database was designed using PostgreSQL.

The schema includes customers, addresses, vendors,
categories, products, inventory, carts, orders,
order items, payments, shipments and reviews.

Primary keys uniquely identify records, while foreign
keys maintain relationships between related entities.

CHECK, UNIQUE and NOT NULL constraints enforce
business rules and improve data integrity.

The core relational design follows Third Normal Form
(3NF), reducing unnecessary duplication and update
anomalies.

Monetary values use NUMERIC data types to preserve
financial precision.

Product name and price snapshots are stored in
order items to preserve historical purchase details.

## 3. Portfolio 2 — SQL Querying and Optimisation

The SQL implementation demonstrates joins,
aggregation, Common Table Expressions, window
functions and JSONB searches.

A composite index on order status and creation time
is used as an optimisation experiment.

EXPLAIN ANALYZE and buffer statistics are used to
inspect query execution plans before and after
the index is created.

The actual execution plan and timing observations
are documented using results obtained from the
local PostgreSQL environment.

An index does not always improve performance,
particularly when the table contains very few rows.

## 4. Portfolio 3 — Transactions and Concurrency

The transaction design demonstrates how checkout
operations can be executed atomically.

Inventory updates use row-level locking and guarded
updates to prevent concurrent transactions from
selling unavailable stock.

The concurrency exercise uses two database sessions.

The first session locks an inventory record while
the second session attempts to update the same record.

The second transaction waits for the first transaction
to commit or roll back.

The application must check the number of affected
rows and roll back checkout if sufficient inventory
is unavailable.

## 5. Portfolio 4 — NoSQL Databases

MongoDB is used to store product catalogue documents.

The document model supports category-specific
attributes such as smartphone storage capacity,
blender power ratings and product variants.

Redis is used to store shopping cart quantities,
product cache entries and product view counters.

These systems improve flexibility and access speed.

However, PostgreSQL remains the authoritative source
for orders, payments and inventory.

## 6. Portfolio 5 — Distributed Databases and Cloud

Docker Compose is used to run PostgreSQL, MongoDB
and Redis as separate local services.

The proposed production architecture uses PostgreSQL
primary and read replicas, MongoDB replica sets and
a resilient Redis deployment.

The design also demonstrates timestamp-based
partitioning for order event records.

Read/write routing must consider replication lag
and read-after-write consistency requirements.

The architecture separates flexible catalogue and
cache workloads from critical transactional data.

## 7. Conclusion

The ShopSphere database architecture demonstrates
how relational and NoSQL technologies can work
together in an e-commerce environment.

PostgreSQL provides transactional consistency,
MongoDB supports flexible catalogue structures,
and Redis provides low-latency access to temporary
application data.

The design prioritises data integrity, query
performance, concurrency control and scalability.

## 8. Evidence and Personal Reflection

Attach the following evidence:

1. Entity Relationship Diagram.
2. PostgreSQL schema and sample data output.
3. Query execution plans before and after indexing.
4. Two-session concurrency test screenshots.
5. MongoDB document and aggregation output.
6. Redis cart and TTL output.
7. Docker Compose service status.
8. GitHub repository and commit history.

### Personal Reflection

[Write your own reflection. Explain what you learned
about database normalisation, query optimisation,
transaction isolation, NoSQL data modelling and
distributed database architecture.]

### AI Use Declaration

AI assistance was used to help structure and draft
parts of this portfolio. I reviewed and adapted
the materials and take responsibility for the
accuracy of the work I submit.

[Edit this declaration to accurately describe your
actual use of AI assistance.]