# Portfolio 4 — NoSQL Database Implementation

## Introduction

ShopSphere uses MongoDB and Redis for workloads
that do not require the same relational structure
as orders and payments.

## MongoDB

MongoDB stores product catalogue documents.

Products may have different attributes:
- Smartphones have storage capacity and colour.
- Blenders have power ratings and capacity.
- Clothing has sizes and material types.

A document database allows these attributes to be
stored flexibly without creating many sparse columns.

## Redis

Redis stores:
- Shopping cart quantities.
- Temporary product cache entries.
- Product view counters.

Redis improves access speed because data is stored
in memory.

## Data consistency

MongoDB and Redis are not the authoritative source
for financial transactions or inventory.

Before checkout, the application must validate
product prices and stock using PostgreSQL.

## Conclusion

MongoDB provides flexible catalogue storage while
Redis provides fast access to temporary cart and
cache data.