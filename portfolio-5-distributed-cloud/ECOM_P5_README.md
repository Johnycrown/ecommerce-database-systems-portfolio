# Portfolio 5 — Distributed Databases and Cloud

## 1. Introduction

ShopSphere uses multiple database technologies
to support different application workloads.

## 2. Local distributed environment

Docker Compose runs three independent services:

- PostgreSQL
- MongoDB
- Redis

Each database runs in its own container and has
its own persistent volume.

This demonstrates local service separation and
polyglot persistence.

Important: running these containers does not by
itself create database replication or high availability.

## 3. Proposed production architecture

### PostgreSQL

A primary database handles writes.

Read replicas can handle eligible read-only queries.

The application must route writes and read-after-write
operations to the primary to avoid stale reads.

### MongoDB

A MongoDB replica set can provide redundancy and
automatic failover for catalogue data.

Sharding can be considered when the data volume or
request throughput requires horizontal distribution.

### Redis

Redis provides low-latency cart and cache access.

A production deployment should use suitable persistence,
replication and monitoring settings.

## 4. Partitioning

The order_events table is partitioned by event time.

Range partitioning helps:
- Manage large event histories.
- Improve queries that filter by event date.
- Archive or remove old partitions efficiently.

## 5. Consistency and availability

Orders, payments and stock require strong consistency.

Product catalogue caches can tolerate some staleness.

The platform must not confirm an order or payment
based only on stale cached information.

Payment callbacks should be idempotent. A unique
provider reference helps prevent duplicate processing.

## 6. Security and operations

Production deployment should include:
- Encrypted database connections.
- Managed secrets.
- Least-privilege database accounts.
- Automated backups.
- Point-in-time recovery.
- Monitoring and alerting.
- Tested disaster recovery procedures.

## 7. Conclusion

A distributed architecture allows ShopSphere to
select appropriate storage technology for each
workload while maintaining PostgreSQL as the
authoritative source for financial and stock records.