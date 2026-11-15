# Portfolio 3 — Transactions and Concurrency

## Introduction

ShopSphere processes customer orders and inventory
reservations. Concurrent purchases must not cause
the platform to sell more products than are available.

## ACID properties

### Atomicity
Order creation, order items and inventory reservation
must succeed or fail as one transaction.

### Consistency
Database constraints prevent invalid quantities,
negative inventory and invalid order statuses.

### Isolation
Row-level locking prevents concurrent transactions
from consuming the same available inventory.

### Durability
Committed transactions are persisted by PostgreSQL
and protected by its write-ahead logging and recovery
mechanisms.

## Concurrency strategy

The implementation uses SELECT FOR UPDATE to lock
the inventory row.

A competing transaction attempting to update the
same row waits until the first transaction commits
or rolls back.

A guarded UPDATE ensures stock is only reduced when
sufficient inventory remains.

## Expected observation

When Session A locks the inventory row, Session B's
competing update should wait.

After Session A commits, Session B proceeds and
rechecks the stock condition.

If there is insufficient stock, Session B updates
zero rows.

This prevents the application from confirming an
oversold order, provided the application checks
the affected-row count and rolls back when necessary.